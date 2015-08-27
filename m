Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60278 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbbH0JyC (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 27 Aug 2015 05:54:02 -0400
Subject: Re: [RFC bluetooth-next 2/2] at86rf230: add debugfs support
References: <1438874501-19971-1-git-send-email-alex.aring@gmail.com>
 <1438874501-19971-3-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55DEDE30.7040707@osg.samsung.com>
Date: Thu, 27 Aug 2015 11:53:52 +0200
MIME-Version: 1.0
In-Reply-To: <1438874501-19971-3-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 06/08/15 17:21, Alexander Aring wrote:
> This patch introduce debugfs support for collect trac status stats. To
> clear the stats ifdown the interface of at86rf230 and start the
> interface again.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   drivers/net/ieee802154/Kconfig     |   7 ++
>   drivers/net/ieee802154/at86rf230.c | 166 +++++++++++++++++++++++++++++++++----
>   drivers/net/ieee802154/at86rf230.h |   8 ++
>   3 files changed, 167 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/ieee802154/Kconfig b/drivers/net/ieee802154/Kconfig
> index 1dd5ab8..5a614b2 100644
> --- a/drivers/net/ieee802154/Kconfig
> +++ b/drivers/net/ieee802154/Kconfig
> @@ -32,6 +32,13 @@ config IEEE802154_AT86RF230
>   	  This driver can also be built as a module. To do so, say M here.
>   	  the module will be called 'at86rf230'.
>   
> +config IEEE802154_AT86RF230_DEBUGFS
> +	depends on IEEE802154_AT86RF230
> +	bool "AT86RF230 debugfs interface"
> +	depends on DEBUG_FS
> +	---help---
> +	  This option compiles debugfs code for the at86rf230 driver.
> +
>   config IEEE802154_MRF24J40
>   	tristate "Microchip MRF24J40 transceiver driver"
>   	depends on IEEE802154_DRIVERS && MAC802154
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index 39485d0..b4a3c11 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -31,6 +31,7 @@
>   #include <linux/skbuff.h>
>   #include <linux/of_gpio.h>
>   #include <linux/ieee802154.h>
> +#include <linux/debugfs.h>
>   
>   #include <net/mac802154.h>
>   #include <net/cfg802154.h>
> @@ -83,6 +84,16 @@ struct at86rf230_state_change {
>   	bool irq_enable;
>   };
>   
> +struct at86rf230_trac {
> +	u64 success;
> +	u64 success_data_pending;
> +	u64 success_wait_for_ack;
> +	u64 channel_access_failure;
> +	u64 no_ack;
> +	u64 invalid;
> +	u64 reserved;

What are you using the reserved for here? I can see that the trac states 
4 and 6 are not assigned. Are you collecting them here? Why?
> +};
> +
>   struct at86rf230_local {
>   	struct spi_device *spi;
>   
> @@ -103,6 +114,8 @@ struct at86rf230_local {
>   	u8 tx_retry;
>   	struct sk_buff *tx_skb;
>   	struct at86rf230_state_change tx;
> +
> +	struct at86rf230_trac trac;
>   };
>   
>   #define AT86RF2XX_NUMREGS 0x3F
> @@ -668,6 +681,33 @@ at86rf230_tx_trac_check(void *context)
>   	struct at86rf230_state_change *ctx = context;
>   	struct at86rf230_local *lp = ctx->lp;
>   
> +	if (IS_ENABLED(CONFIG_IEEE802154_AT86RF230_DEBUGFS)) {
> +		u8 trac = TRAC_MASK(ctx->buf[1]);
> +
> +		switch (trac) {
> +		case TRAC_SUCCESS:
> +			lp->trac.success++;
> +			break;
> +		case TRAC_SUCCESS_DATA_PENDING:
> +			lp->trac.success_data_pending++;
> +			break;
> +		case TRAC_CHANNEL_ACCESS_FAILURE:
> +			lp->trac.channel_access_failure++;
> +			break;
> +		case TRAC_NO_ACK:
> +			lp->trac.no_ack++;
> +			break;
> +		case TRAC_INVALID:
> +			lp->trac.invalid++;
> +			break;
> +		default:
> +			lp->trac.reserved++;

Please put the default state at the end of the switch/case statement.
> +		case TRAC_SUCCESS_WAIT_FOR_ACK:
> +			WARN_ONCE(1, "received tx trac status %d\n", trac);
> +			break;
> +		}
> +	}
> +
>   	at86rf230_async_state_change(lp, &lp->irq, STATE_TX_ON,
>   				     at86rf230_tx_on, true);
>   }
> @@ -704,13 +744,36 @@ at86rf230_rx_read_frame_complete(void *context)
>   }
>   
>   static void
> -at86rf230_rx_read_frame(void *context)
> +at86rf230_rx_trac_check(void *context)
>   {
>   	struct at86rf230_state_change *ctx = context;
>   	struct at86rf230_local *lp = ctx->lp;
>   	u8 *buf = ctx->buf;
>   	int rc;
>   
> +	if (IS_ENABLED(CONFIG_IEEE802154_AT86RF230_DEBUGFS)) {
> +		u8 trac = TRAC_MASK(buf[1]);
> +
> +		switch (trac) {
> +		case TRAC_SUCCESS:
> +			lp->trac.success++;
> +			break;
> +		case TRAC_SUCCESS_WAIT_FOR_ACK:
> +			lp->trac.success_wait_for_ack++;
> +			break;
> +		case TRAC_INVALID:
> +			lp->trac.invalid++;
> +			break;
> +		default:
> +			lp->trac.reserved++;

Default state please at the end.

> +		case TRAC_SUCCESS_DATA_PENDING:
> +		case TRAC_CHANNEL_ACCESS_FAILURE:
> +		case TRAC_NO_ACK:
> +			WARN_ONCE(1, "received rx trac status %d\n", trac);
> +			break;
> +		}
> +	}
> +
>   	buf[0] = CMD_FB;
>   	ctx->trx.len = AT86RF2XX_MAX_BUF;
>   	ctx->msg.complete = at86rf230_rx_read_frame_complete;
> @@ -723,18 +786,6 @@ at86rf230_rx_read_frame(void *context)
>   }
>   
>   static void
> -at86rf230_rx_trac_check(void *context)
> -{
> -	/* Possible check on trac status here. This could be useful to make
> -	 * some stats why receive is failed. Not used at the moment, but it's
> -	 * maybe timing relevant. Datasheet doesn't say anything about this.
> -	 * The programming guide say do it so.
> -	 */
> -
> -	at86rf230_rx_read_frame(context);
> -}
> -
> -static void
>   at86rf230_irq_trx_end(struct at86rf230_local *lp)
>   {
>   	if (lp->is_tx) {
> @@ -899,6 +950,10 @@ at86rf230_start(struct ieee802154_hw *hw)
>   {
>   	struct at86rf230_local *lp = hw->priv;
>   
> +	/* reset trac stats on start */
> +	if (IS_ENABLED(CONFIG_IEEE802154_AT86RF230_DEBUGFS))
> +		memset(&lp->trac, 0, sizeof(struct at86rf230_trac));
> +
>   	at86rf230_awake(lp);
>   	enable_irq(lp->spi->irq);
>   
> @@ -1599,6 +1654,82 @@ at86rf230_setup_spi_messages(struct at86rf230_local *lp)
>   	lp->tx.timer.function = at86rf230_async_state_timer;
>   }
>   
> +#ifdef CONFIG_IEEE802154_AT86RF230_DEBUGFS
> +static struct dentry *at86rf230_debugfs_root;
> +
> +static int at86rf230_stats_show(struct seq_file *file, void *offset)
> +{
> +	struct at86rf230_local *lp = file->private;
> +	int ret;
> +
> +	ret = seq_printf(file, "SUCCESS:\t\t%8llu\n", lp->trac.success);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = seq_printf(file, "SUCCESS_DATA_PENDING:\t%8llu\n",
> +			 lp->trac.success_data_pending);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = seq_printf(file, "SUCCESS_WAIT_FOR_ACK:\t%8llu\n",
> +			 lp->trac.success_wait_for_ack);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = seq_printf(file, "CHANNEL_ACCESS_FAILURE:\t%8llu\n",
> +			 lp->trac.channel_access_failure);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = seq_printf(file, "NO_ACK:\t\t\t%8llu\n", lp->trac.no_ack);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = seq_printf(file, "INVALID:\t\t%8llu\n", lp->trac.invalid);
> +	if (ret < 0)
> +		return ret;
> +
> +	return seq_printf(file, "RESERVED:\t\t%8llu\n", lp->trac.reserved);
> +}
> +
> +static int at86rf230_stats_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, at86rf230_stats_show, inode->i_private);
> +}
> +
> +static const struct file_operations at86rf230_stats_fops = {
> +	.open		= at86rf230_stats_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static int at86rf230_debugfs_init(struct at86rf230_local *lp)
> +{
> +	struct dentry *stats;
> +
> +	at86rf230_debugfs_root = debugfs_create_dir("at86rf230", NULL);

If we want to support systems with several transceivers we should switch 
the static at86rf230 above to something like at86rf23-spi-XXXX by using 
the assigned SPI device to identify it cleanly.
> +	if (!at86rf230_debugfs_root)
> +		return -ENOMEM;
> +
> +	stats = debugfs_create_file("trac_stats", S_IRUGO,
> +				    at86rf230_debugfs_root, lp,
> +				    &at86rf230_stats_fops);
> +	if (!stats)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void at86rf230_debugfs_remove(void)
> +{
> +	debugfs_remove_recursive(at86rf230_debugfs_root);
> +}
> +#else
> +static int at86rf230_debugfs_init(struct at86rf230_local *lp) { return 0; }
> +static void at86rf230_debugfs_remove(void) { }
> +#endif
> +
>   static int at86rf230_probe(struct spi_device *spi)
>   {
>   	struct ieee802154_hw *hw;
> @@ -1694,12 +1825,18 @@ static int at86rf230_probe(struct spi_device *spi)
>   	/* going into sleep by default */
>   	at86rf230_sleep(lp);
>   
> -	rc = ieee802154_register_hw(lp->hw);
> +	rc = at86rf230_debugfs_init(lp);
>   	if (rc)
>   		goto free_dev;
>   
> +	rc = ieee802154_register_hw(lp->hw);
> +	if (rc)
> +		goto free_debugfs;
> +
>   	return rc;
>   
> +free_debugfs:
> +	at86rf230_debugfs_remove();
>   free_dev:
>   	ieee802154_free_hw(lp->hw);
>   
> @@ -1714,6 +1851,7 @@ static int at86rf230_remove(struct spi_device *spi)
>   	at86rf230_write_subreg(lp, SR_IRQ_MASK, 0);
>   	ieee802154_unregister_hw(lp->hw);
>   	ieee802154_free_hw(lp->hw);
> +	at86rf230_debugfs_remove();
>   	dev_dbg(&spi->dev, "unregistered at86rf230\n");
>   
>   	return 0;
> diff --git a/drivers/net/ieee802154/at86rf230.h b/drivers/net/ieee802154/at86rf230.h
> index 1e6d1cc..fd9c1f4 100644
> --- a/drivers/net/ieee802154/at86rf230.h
> +++ b/drivers/net/ieee802154/at86rf230.h
> @@ -216,5 +216,13 @@
>   #define STATE_TRANSITION_IN_PROGRESS 0x1F
>   
>   #define TRX_STATE_MASK		(0x1F)
> +#define TRAC_MASK(x)		((x & 0xe0) >> 5)
> +
> +#define TRAC_SUCCESS			0
> +#define TRAC_SUCCESS_DATA_PENDING	1
> +#define TRAC_SUCCESS_WAIT_FOR_ACK	2
> +#define TRAC_CHANNEL_ACCESS_FAILURE	3
> +#define TRAC_NO_ACK			5
> +#define TRAC_INVALID			7
Where did you find those? I looked through my copies of the 
at86rf231/233 datasheets and could not find them. Page number would be 
helpful.

regards
Stefan Schmidt

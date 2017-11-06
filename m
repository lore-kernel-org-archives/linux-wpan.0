Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47852 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753071AbdKFPfm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Nov 2017 10:35:42 -0500
Subject: Re: [PATCH 04/14] ieee802154: atusb: switch from uint8_t to u8
References: <20170922121405.31789-1-stefan@osg.samsung.com>
 <20170922121405.31789-5-stefan@osg.samsung.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <dcbf0342-6206-03b8-ba2e-dc48f98ee7a7@datenfreihafen.org>
Date: Mon, 6 Nov 2017 16:35:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170922121405.31789-5-stefan@osg.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us

Hello.

On 22.09.2017 14:13, Stefan Schmidt wrote:
> Switch top the preferred kernel type naming.
> Found by checkpatch.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  drivers/net/ieee802154/atusb.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index 115fa3f37a86..a4a326933977 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -63,7 +63,7 @@ struct atusb {
>  	struct usb_ctrlrequest tx_dr;
>  	struct urb *tx_urb;
>  	struct sk_buff *tx_skb;
> -	uint8_t tx_ack_seq;		/* current TX ACK sequence number */
> +	u8 tx_ack_seq;		/* current TX ACK sequence number */
>  
>  	/* Firmware variable */
>  	unsigned char fw_ver_maj;	/* Firmware major version number */
> @@ -107,7 +107,7 @@ static int atusb_control_msg(struct atusb *atusb, unsigned int pipe,
>  	return ret;
>  }
>  
> -static int atusb_command(struct atusb *atusb, uint8_t cmd, uint8_t arg)
> +static int atusb_command(struct atusb *atusb, u8 cmd, u8 arg)
>  {
>  	struct usb_device *usb_dev = atusb->usb_dev;
>  
> @@ -116,7 +116,7 @@ static int atusb_command(struct atusb *atusb, uint8_t cmd, uint8_t arg)
>  				 cmd, ATUSB_REQ_TO_DEV, arg, 0, NULL, 0, 1000);
>  }
>  
> -static int atusb_write_reg(struct atusb *atusb, uint8_t reg, uint8_t value)
> +static int atusb_write_reg(struct atusb *atusb, u8 reg, u8 value)
>  {
>  	struct usb_device *usb_dev = atusb->usb_dev;
>  
> @@ -127,12 +127,12 @@ static int atusb_write_reg(struct atusb *atusb, uint8_t reg, uint8_t value)
>  				 value, reg, NULL, 0, 1000);
>  }
>  
> -static int atusb_read_reg(struct atusb *atusb, uint8_t reg)
> +static int atusb_read_reg(struct atusb *atusb, u8 reg)
>  {
>  	struct usb_device *usb_dev = atusb->usb_dev;
>  	int ret;
> -	uint8_t *buffer;
> -	uint8_t value;
> +	u8 *buffer;
> +	u8 value;
>  
>  	buffer = kmalloc(1, GFP_KERNEL);
>  	if (!buffer)
> @@ -153,11 +153,11 @@ static int atusb_read_reg(struct atusb *atusb, uint8_t reg)
>  	}
>  }
>  
> -static int atusb_write_subreg(struct atusb *atusb, uint8_t reg, uint8_t mask,
> -			      uint8_t shift, uint8_t value)
> +static int atusb_write_subreg(struct atusb *atusb, u8 reg, u8 mask,
> +			      u8 shift, u8 value)
>  {
>  	struct usb_device *usb_dev = atusb->usb_dev;
> -	uint8_t orig, tmp;
> +	u8 orig, tmp;
>  	int ret = 0;
>  
>  	dev_dbg(&usb_dev->dev, "atusb_write_subreg: 0x%02x <- 0x%02x\n",
> @@ -263,10 +263,10 @@ static void atusb_work_urbs(struct work_struct *work)
>  
>  /* ----- Asynchronous USB -------------------------------------------------- */
>  
> -static void atusb_tx_done(struct atusb *atusb, uint8_t seq)
> +static void atusb_tx_done(struct atusb *atusb, u8 seq)
>  {
>  	struct usb_device *usb_dev = atusb->usb_dev;
> -	uint8_t expect = atusb->tx_ack_seq;
> +	u8 expect = atusb->tx_ack_seq;
>  
>  	dev_dbg(&usb_dev->dev, "atusb_tx_done (0x%02x/0x%02x)\n", seq, expect);
>  	if (seq == expect) {
> @@ -289,7 +289,7 @@ static void atusb_in_good(struct urb *urb)
>  	struct usb_device *usb_dev = urb->dev;
>  	struct sk_buff *skb = urb->context;
>  	struct atusb *atusb = SKB_ATUSB(skb);
> -	uint8_t len, lqi;
> +	u8 len, lqi;
>  
>  	if (!urb->actual_length) {
>  		dev_dbg(&usb_dev->dev, "atusb_in: zero-sized URB ?\n");
> @@ -882,7 +882,7 @@ static int atusb_get_and_show_build(struct atusb *atusb)
>  static int atusb_get_and_conf_chip(struct atusb *atusb)
>  {
>  	struct usb_device *usb_dev = atusb->usb_dev;
> -	uint8_t man_id_0, man_id_1, part_num, version_num;
> +	u8 man_id_0, man_id_1, part_num, version_num;
>  	const char *chip;
>  	struct ieee802154_hw *hw = atusb->hw;
>  
> 

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt

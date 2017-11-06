Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47855 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbdKFPfx (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Nov 2017 10:35:53 -0500
Subject: Re: [PATCH 05/14] ieee802154: atusb: use __func__ macro for debug
 messages
References: <20170922121405.31789-1-stefan@osg.samsung.com>
 <20170922121405.31789-6-stefan@osg.samsung.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <eee44775-d85b-ffe0-8312-05766714cca5@datenfreihafen.org>
Date: Mon, 6 Nov 2017 16:35:51 +0100
MIME-Version: 1.0
In-Reply-To: <20170922121405.31789-6-stefan@osg.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us

Hello.

On 22.09.2017 14:13, Stefan Schmidt wrote:
> Instead of having the function name hard-coded (it might change and we
> forgot to update them in the debug output) we can use __func__ instead
> and also shorter the line so we do not need to break it.
> Found by checkpatch.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  drivers/net/ieee802154/atusb.c | 41 +++++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index a4a326933977..bb02e37257cf 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -101,8 +101,8 @@ static int atusb_control_msg(struct atusb *atusb, unsigned int pipe,
>  	if (ret < 0) {
>  		atusb->err = ret;
>  		dev_err(&usb_dev->dev,
> -			"atusb_control_msg: req 0x%02x val 0x%x idx 0x%x, error %d\n",
> -			request, value, index, ret);
> +			"%s: req 0x%02x val 0x%x idx 0x%x, error %d\n",
> +			__func__, request, value, index, ret);
>  	}
>  	return ret;
>  }
> @@ -111,7 +111,7 @@ static int atusb_command(struct atusb *atusb, u8 cmd, u8 arg)
>  {
>  	struct usb_device *usb_dev = atusb->usb_dev;
>  
> -	dev_dbg(&usb_dev->dev, "atusb_command: cmd = 0x%x\n", cmd);
> +	dev_dbg(&usb_dev->dev, "%s: cmd = 0x%x\n", __func__, cmd);
>  	return atusb_control_msg(atusb, usb_sndctrlpipe(usb_dev, 0),
>  				 cmd, ATUSB_REQ_TO_DEV, arg, 0, NULL, 0, 1000);
>  }
> @@ -120,8 +120,7 @@ static int atusb_write_reg(struct atusb *atusb, u8 reg, u8 value)
>  {
>  	struct usb_device *usb_dev = atusb->usb_dev;
>  
> -	dev_dbg(&usb_dev->dev, "atusb_write_reg: 0x%02x <- 0x%02x\n",
> -		reg, value);
> +	dev_dbg(&usb_dev->dev, "%s: 0x%02x <- 0x%02x\n", __func__, reg, value);
>  	return atusb_control_msg(atusb, usb_sndctrlpipe(usb_dev, 0),
>  				 ATUSB_REG_WRITE, ATUSB_REQ_TO_DEV,
>  				 value, reg, NULL, 0, 1000);
> @@ -138,7 +137,7 @@ static int atusb_read_reg(struct atusb *atusb, u8 reg)
>  	if (!buffer)
>  		return -ENOMEM;
>  
> -	dev_dbg(&usb_dev->dev, "atusb: reg = 0x%x\n", reg);
> +	dev_dbg(&usb_dev->dev, "%s: reg = 0x%x\n", __func__, reg);
>  	ret = atusb_control_msg(atusb, usb_rcvctrlpipe(usb_dev, 0),
>  				ATUSB_REG_READ, ATUSB_REQ_FROM_DEV,
>  				0, reg, buffer, 1, 1000);
> @@ -160,8 +159,7 @@ static int atusb_write_subreg(struct atusb *atusb, u8 reg, u8 mask,
>  	u8 orig, tmp;
>  	int ret = 0;
>  
> -	dev_dbg(&usb_dev->dev, "atusb_write_subreg: 0x%02x <- 0x%02x\n",
> -		reg, value);
> +	dev_dbg(&usb_dev->dev, "%s: 0x%02x <- 0x%02x\n", __func__, reg, value);
>  
>  	orig = atusb_read_reg(atusb, reg);
>  
> @@ -268,7 +266,7 @@ static void atusb_tx_done(struct atusb *atusb, u8 seq)
>  	struct usb_device *usb_dev = atusb->usb_dev;
>  	u8 expect = atusb->tx_ack_seq;
>  
> -	dev_dbg(&usb_dev->dev, "atusb_tx_done (0x%02x/0x%02x)\n", seq, expect);
> +	dev_dbg(&usb_dev->dev, "%s (0x%02x/0x%02x)\n", __func__, seq, expect);
>  	if (seq == expect) {
>  		/* TODO check for ifs handling in firmware */
>  		ieee802154_xmit_complete(atusb->hw, atusb->tx_skb, false);
> @@ -328,7 +326,7 @@ static void atusb_in(struct urb *urb)
>  	struct sk_buff *skb = urb->context;
>  	struct atusb *atusb = SKB_ATUSB(skb);
>  
> -	dev_dbg(&usb_dev->dev, "atusb_in: status %d len %d\n",
> +	dev_dbg(&usb_dev->dev, "%s: status %d len %d\n", __func__,
>  		urb->status, urb->actual_length);
>  	if (urb->status) {
>  		if (urb->status == -ENOENT) { /* being killed */
> @@ -336,7 +334,7 @@ static void atusb_in(struct urb *urb)
>  			urb->context = NULL;
>  			return;
>  		}
> -		dev_dbg(&usb_dev->dev, "atusb_in: URB error %d\n", urb->status);
> +		dev_dbg(&usb_dev->dev, "%s: URB error %d\n", __func__, urb->status);
>  	} else {
>  		atusb_in_good(urb);
>  	}
> @@ -390,7 +388,7 @@ static int atusb_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
>  	struct usb_device *usb_dev = atusb->usb_dev;
>  	int ret;
>  
> -	dev_dbg(&usb_dev->dev, "atusb_xmit (%d)\n", skb->len);
> +	dev_dbg(&usb_dev->dev, "%s (%d)\n", __func__, skb->len);
>  	atusb->tx_skb = skb;
>  	atusb->tx_ack_seq++;
>  	atusb->tx_dr.wIndex = cpu_to_le16(atusb->tx_ack_seq);
> @@ -401,7 +399,7 @@ static int atusb_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
>  			     (unsigned char *)&atusb->tx_dr, skb->data,
>  			     skb->len, atusb_xmit_complete, NULL);
>  	ret = usb_submit_urb(atusb->tx_urb, GFP_ATOMIC);
> -	dev_dbg(&usb_dev->dev, "atusb_xmit done (%d)\n", ret);
> +	dev_dbg(&usb_dev->dev, "%s done (%d)\n", __func__, ret);
>  	return ret;
>  }
>  
> @@ -422,7 +420,7 @@ static int atusb_set_hw_addr_filt(struct ieee802154_hw *hw,
>  	if (changed & IEEE802154_AFILT_SADDR_CHANGED) {
>  		u16 addr = le16_to_cpu(filt->short_addr);
>  
> -		dev_vdbg(dev, "atusb_set_hw_addr_filt called for saddr\n");
> +		dev_vdbg(dev, "%s called for saddr\n", __func__);
>  		atusb_write_reg(atusb, RG_SHORT_ADDR_0, addr);
>  		atusb_write_reg(atusb, RG_SHORT_ADDR_1, addr >> 8);
>  	}
> @@ -430,7 +428,7 @@ static int atusb_set_hw_addr_filt(struct ieee802154_hw *hw,
>  	if (changed & IEEE802154_AFILT_PANID_CHANGED) {
>  		u16 pan = le16_to_cpu(filt->pan_id);
>  
> -		dev_vdbg(dev, "atusb_set_hw_addr_filt called for pan id\n");
> +		dev_vdbg(dev, "%s called for pan id\n", __func__);
>  		atusb_write_reg(atusb, RG_PAN_ID_0, pan);
>  		atusb_write_reg(atusb, RG_PAN_ID_1, pan >> 8);
>  	}
> @@ -439,14 +437,13 @@ static int atusb_set_hw_addr_filt(struct ieee802154_hw *hw,
>  		u8 i, addr[IEEE802154_EXTENDED_ADDR_LEN];
>  
>  		memcpy(addr, &filt->ieee_addr, IEEE802154_EXTENDED_ADDR_LEN);
> -		dev_vdbg(dev, "atusb_set_hw_addr_filt called for IEEE addr\n");
> +		dev_vdbg(dev, "%s called for IEEE addr\n", __func__);
>  		for (i = 0; i < 8; i++)
>  			atusb_write_reg(atusb, RG_IEEE_ADDR_0 + i, addr[i]);
>  	}
>  
>  	if (changed & IEEE802154_AFILT_PANC_CHANGED) {
> -		dev_vdbg(dev,
> -			 "atusb_set_hw_addr_filt called for panc change\n");
> +		dev_vdbg(dev, "%s called for panc change\n", __func__);
>  		if (filt->pan_coord)
>  			atusb_write_subreg(atusb, SR_AACK_I_AM_COORD, 1);
>  		else
> @@ -462,7 +459,7 @@ static int atusb_start(struct ieee802154_hw *hw)
>  	struct usb_device *usb_dev = atusb->usb_dev;
>  	int ret;
>  
> -	dev_dbg(&usb_dev->dev, "atusb_start\n");
> +	dev_dbg(&usb_dev->dev, "%s\n", __func__);
>  	schedule_delayed_work(&atusb->work, 0);
>  	atusb_command(atusb, ATUSB_RX_MODE, 1);
>  	ret = atusb_get_and_clear_error(atusb);
> @@ -476,7 +473,7 @@ static void atusb_stop(struct ieee802154_hw *hw)
>  	struct atusb *atusb = hw->priv;
>  	struct usb_device *usb_dev = atusb->usb_dev;
>  
> -	dev_dbg(&usb_dev->dev, "atusb_stop\n");
> +	dev_dbg(&usb_dev->dev, "%s\n", __func__);
>  	usb_kill_anchored_urbs(&atusb->idle_urbs);
>  	atusb_command(atusb, ATUSB_RX_MODE, 0);
>  	atusb_get_and_clear_error(atusb);
> @@ -1131,7 +1128,7 @@ static void atusb_disconnect(struct usb_interface *interface)
>  {
>  	struct atusb *atusb = usb_get_intfdata(interface);
>  
> -	dev_dbg(&atusb->usb_dev->dev, "atusb_disconnect\n");
> +	dev_dbg(&atusb->usb_dev->dev, "%s\n", __func__);
>  
>  	atusb->shutdown = 1;
>  	cancel_delayed_work_sync(&atusb->work);
> @@ -1148,7 +1145,7 @@ static void atusb_disconnect(struct usb_interface *interface)
>  	usb_set_intfdata(interface, NULL);
>  	usb_put_dev(atusb->usb_dev);
>  
> -	pr_debug("atusb_disconnect done\n");
> +	pr_debug("%s done\n", __func__);
>  }
>  
>  /* The devices we work with */
> 

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt

Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:59225 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985AbcC3IpL (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 30 Mar 2016 04:45:11 -0400
Subject: Re: [PATCH v2 1/3] ieee802154: add security bit check function
References: <1457633643-12535-1-git-send-email-web+oss@zopieux.com>
 <1457988374-31220-1-git-send-email-web+oss@zopieux.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56FB9212.3040004@osg.samsung.com>
Date: Wed, 30 Mar 2016 10:45:06 +0200
MIME-Version: 1.0
In-Reply-To: <1457988374-31220-1-git-send-email-web+oss@zopieux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexandre Macabies <web+oss@zopieux.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Alan Ott <alan@signal11.us>

Hello.

Added Alan Ott in CC.

Alan, can we get your review on this? Its sit son the list for almost 
three weeks now.
If you are to busy just say so and we can get the ACK from Alex and put 
them in.

regards
Stefan Schmidt

On 14/03/16 21:46, Alexandre Macabies wrote:
> ieee802154_is_secen checks if the 802.15.4 security bit is set in the
> frame control field.
>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> Signed-off-by: Alexandre Macabies <web+oss@zopieux.com>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>   include/linux/ieee802154.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
> index d3e4156..56090f1 100644
> --- a/include/linux/ieee802154.h
> +++ b/include/linux/ieee802154.h
> @@ -218,6 +218,7 @@ enum {
>   /* frame control handling */
>   #define IEEE802154_FCTL_FTYPE		0x0003
>   #define IEEE802154_FCTL_ACKREQ		0x0020
> +#define IEEE802154_FCTL_SECEN		0x0004
>   #define IEEE802154_FCTL_INTRA_PAN	0x0040
>   
>   #define IEEE802154_FTYPE_DATA		0x0001
> @@ -233,6 +234,15 @@ static inline int ieee802154_is_data(__le16 fc)
>   }
>   
>   /**
> + * ieee802154_is_secen - check if Security bit is set
> + * @fc: frame control bytes in little-endian byteorder
> + */
> +static inline bool ieee802154_is_secen(__le16 fc)
> +{
> +	return fc & cpu_to_le16(IEEE802154_FCTL_SECEN);
> +}
> +
> +/**
>    * ieee802154_is_ackreq - check if acknowledgment request bit is set
>    * @fc: frame control bytes in little-endian byteorder
>    */


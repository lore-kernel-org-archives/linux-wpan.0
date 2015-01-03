Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:54452 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbbACBDC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 2 Jan 2015 20:03:02 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluetooth-next] af_ieee802154: make header uapi conform
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420127077-25699-1-git-send-email-alex.aring@gmail.com>
Date: Fri, 2 Jan 2015 17:02:57 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <715AC34D-9929-4959-A0E9-48B748F8E22F@holtmann.org>
References: <1420127077-25699-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch uses __u16 and __u8 instead of u16 and u8 typedefs. These
> typedefs coming from linux/types.h and are also easily available in
> standard userspace environments. The af_ieee802154 header is normally
> an userspace header. For now, we just copy this header in an userspace
> application.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> The "int addr_type" should be the above enum. I will fix this later. This
> header has also other various issues. For now I just want the same version
> in userspace which is also inside kernelspace.
> 
> include/net/af_ieee802154.h | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/af_ieee802154.h b/include/net/af_ieee802154.h
> index 7d38e2f..63af3f2 100644
> --- a/include/net/af_ieee802154.h
> +++ b/include/net/af_ieee802154.h
> @@ -21,6 +21,7 @@
> #define _AF_IEEE802154_H
> 
> #include <linux/socket.h> /* for sa_family_t */
> +#include <linux/types.h>
> 
> enum {
> 	IEEE802154_ADDR_NONE = 0x0,
> @@ -34,10 +35,10 @@ enum {
> 
> struct ieee802154_addr_sa {
> 	int addr_type;
> -	u16 pan_id;
> +	__u16 pan_id;
> 	union {
> -		u8 hwaddr[IEEE802154_ADDR_LEN];
> -		u16 short_addr;
> +		__u8 hwaddr[IEEE802154_ADDR_LEN];
> +		__u16 short_addr;
> 	};
> };

which address information is this? Are these the socket addresses you use for bind(), connect() etc.

In that case shouldn't this be sa_family_t instead.

Regards

Marcel


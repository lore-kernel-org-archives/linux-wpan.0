Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34439 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbbCIJdU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 9 Mar 2015 05:33:20 -0400
Received: by wiwl15 with SMTP id l15so17323551wiw.1
        for <linux-wpan@vger.kernel.org>; Mon, 09 Mar 2015 02:33:19 -0700 (PDT)
Date: Mon, 9 Mar 2015 10:33:13 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 1/2] of: net: add support for extended
 address
Message-ID: <20150309093312.GA711@omega>
References: <1425802643-5798-1-git-send-email-alex.aring@gmail.com>
 <1425802643-5798-2-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1425802643-5798-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de

Hi,

some notes from me which I figured out for reviewing right now.

On Sun, Mar 08, 2015 at 09:17:22AM +0100, Alexander Aring wrote:
...
> +}
> +EXPORT_SYMBOL(of_get_extended_address);
> diff --git a/include/linux/of_net.h b/include/linux/of_net.h
> index 34597c8..6e677ab 100644
> --- a/include/linux/of_net.h
> +++ b/include/linux/of_net.h
> @@ -11,6 +11,7 @@
>  #include <linux/of.h>
>  extern int of_get_phy_mode(struct device_node *np);
>  extern const void *of_get_mac_address(struct device_node *np);
> +extern __le64 of_get_extended_address(struct device_node *np);
>  #else
>  static inline int of_get_phy_mode(struct device_node *np)
>  {
> @@ -21,6 +22,11 @@ static inline const void *of_get_mac_address(struct device_node *np)
>  {
>  	return NULL;
>  }
> +
> +static inline __le64 of_get_extended_address(struct device_node *np)
> +{
> +	return cpu_to_le64(0x0000000000000000ULL);
> +}
>  #endif
>  

I need to be sure that __le64 is definied here from include of
<linux/of.h>. I didn't check that right now.

- Alex

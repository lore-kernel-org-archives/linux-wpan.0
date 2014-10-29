Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:50606 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468AbaJ2JEX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 05:04:23 -0400
Received: by mail-lb0-f172.google.com with SMTP id n15so2096141lbi.17
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 02:04:21 -0700 (PDT)
Date: Wed, 29 Oct 2014 10:04:14 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next v2] MAINTAINERS: add cc2520 driver
 maintainer
Message-ID: <20141029090410.GA30457@omega>
References: <1414571553-9567-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1414571553-9567-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Wed, Oct 29, 2014 at 02:02:33PM +0530, Varka Bhadram wrote:
> This patch adds maintainer for cc2520 radio driver.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  MAINTAINERS |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 15867a6..43dc166 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4698,6 +4698,14 @@ F:	include/net/cfg802154.h
>  F:	include/net/ieee802154_netdev.h
>  F:	Documentation/networking/ieee802154.txt
>  
> +CC2520 IEEE-802.15.4 RADIO DRIVER
> +M:	Varka Bhadram <varkabhadram@gmail.com>
> +L:	linux-wpan@vger.kernel.org
> +S:	Maintained
> +F:	drivers/net/ieee802154/cc2520.c
> +F:	include/linux/spi/cc2520.h
> +F:	Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
> +

The sequence in this file need to be in lexicographical order. Please
fix that.
 
- Alex

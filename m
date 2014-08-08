Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:53226 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391AbaHHG2X (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Aug 2014 02:28:23 -0400
Received: by mail-we0-f179.google.com with SMTP id u57so5171543wes.38
        for <linux-wpan@vger.kernel.org>; Thu, 07 Aug 2014 23:28:22 -0700 (PDT)
Received: from omega (p20030064A9351216E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a935:1216:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id gl4sm3937779wib.19.2014.08.07.23.28.21
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Aug 2014 23:28:21 -0700 (PDT)
Date: Fri, 8 Aug 2014 08:28:16 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140808062814.GA20055@omega>
References: <1407479079-5114-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1407479079-5114-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH wpan-next] 6lowpan_rtnl: fix correct return of errno value
To: linux-wpan@vger.kernel.org

On Fri, Aug 08, 2014 at 08:24:39AM +0200, Alexander Aring wrote:
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  net/ieee802154/6lowpan_rtnl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
> index 0acd273..b6ec3b1 100644
> --- a/net/ieee802154/6lowpan_rtnl.c
> +++ b/net/ieee802154/6lowpan_rtnl.c
> @@ -238,7 +238,7 @@ lowpan_alloc_frag(struct sk_buff *skb, int size,
>  			return ERR_PTR(-rc);
>  		}
>  	} else {
> -		frag = ERR_PTR(ENOMEM);
> +		frag = ERR_PTR(-ENOMEM);
>  	}
>  
>  	return frag;
> -- 
> 2.0.3
> 

Sorry, I will also add a "ieee802154: " to beginning of this commit msg.

- Alex

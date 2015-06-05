Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:45788 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053AbbFEQIj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Jun 2015 12:08:39 -0400
Date: Fri, 5 Jun 2015 18:08:35 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH wpan-tools 2/3] gitignore: add generated iwpan-info
Message-ID: <20150605160835.GA5850@bogon.m.sigxcpu.org>
References: <1433511132-15818-1-git-send-email-stefan@osg.samsung.com>
 <1433511132-15818-3-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1433511132-15818-3-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>

On Fri, Jun 05, 2015 at 03:32:11PM +0200, Stefan Schmidt wrote:
> From: Stefan Schmidt <s.schmidt@samsung.com>
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  src/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/.gitignore b/src/.gitignore
> index d0989d6..356ac21 100644
> --- a/src/.gitignore
> +++ b/src/.gitignore
> @@ -1,5 +1,6 @@
>  .deps
>  iwpan
> +iwpan-info.o
>  iwpan-interface.o
>  iwpan-iwpan.o
>  iwpan-sections.o

What about using a

*.o

wildcard? Everythng else seems cumbersome in the long run.
Cheers,
 -- Guido

> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

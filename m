Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58383 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753250AbbHSITq (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 19 Aug 2015 04:19:46 -0400
Subject: Re: [PATCH wpan-tools] build: remove leftover from Makefile.am
References: <1439885243-22609-1-git-send-email-stefan@osg.samsung.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55D43C1F.8030106@osg.samsung.com>
Date: Wed, 19 Aug 2015 10:19:43 +0200
MIME-Version: 1.0
In-Reply-To: <1439885243-22609-1-git-send-email-stefan@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hello.

On 18/08/15 10:07, Stefan Schmidt wrote:
> We have no abc folder in src. Looks like this was bootstrapped with some
> Makefile.am from libabc.
>
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>   Makefile.am | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 2584cb2..2261603 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -7,7 +7,6 @@ AM_CPPFLAGS = \
>   	-include $(top_builddir)/config.h \
>   	-DSYSCONFDIR=\""$(sysconfdir)"\" \
>   	-DLIBEXECDIR=\""$(libexecdir)"\" \
> -	-I${top_srcdir}/src/abc \
>   	-I${top_srcdir}/src
>   
>   AM_CFLAGS = ${WPAN_TOOLS_CFLAGS} \

Pushed to the repo now.

regards
Stefan Schmidt

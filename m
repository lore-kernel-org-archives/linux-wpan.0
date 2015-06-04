Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35734 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbFDHFD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 03:05:03 -0400
Received: by wiga1 with SMTP id a1so37421891wig.0
        for <linux-wpan@vger.kernel.org>; Thu, 04 Jun 2015 00:05:02 -0700 (PDT)
Date: Thu, 4 Jun 2015 09:04:56 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools] interface: fix interface type info
Message-ID: <20150604070455.GA1232@omega>
References: <1433310698-14691-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1433310698-14691-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Wed, Jun 03, 2015 at 11:21:38AM +0530, Varka Bhadram wrote:
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  src/interface.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/interface.c b/src/interface.c
> index e501763..1c59876 100644
> --- a/src/interface.c
> +++ b/src/interface.c
> @@ -28,7 +28,7 @@ const char *iftype_name(enum nl802154_iftype iftype)
>  	case NL802154_IFTYPE_COORD:
>  		return "coordinator";
>  	default:
> -		sprintf(modebuf, "Unknown mode (%d)", iftype);
> +		sprintf(modebuf, "Invalid iftype (%d)", iftype);
>  		return modebuf;

This error message is like iw tool. I don't know how we strict we should
make the behaviour like wireless here. I think it's okay to change that.

But note there is also a "modebuf" and you changed "Unknown mode ..." to
"Unknown iftype..." if you want to change it then I would assume to make
everything to "iftypeFOOBAR". I mean change "modebuf" to "iftypebuf" or
something else.

I can understand "Unknown mode" is confusing. But to handle now "iftypeFOO"
and "modeFOO" is more confusing than before.

- Alex

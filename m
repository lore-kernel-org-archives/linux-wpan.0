Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:37185 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaIFIRZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Sep 2014 04:17:25 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so12813576wes.11
        for <linux-wpan@vger.kernel.org>; Sat, 06 Sep 2014 01:17:24 -0700 (PDT)
Date: Sat, 6 Sep 2014 10:17:05 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 wpan-tools 1/6] nl_extras: initial commit for extra nl
 bindings
Message-ID: <20140906081703.GA19201@omega>
References: <1409823174-22491-1-git-send-email-alex.aring@gmail.com>
 <1409823174-22491-2-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1409823174-22491-2-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: jiri@resnulli.us

Hi Jiri Pirko,

I need a special header for my netlink application for introduce the
signed integer types, which are not in current release of libnl.

First I took the headr from [0].
Then I saw it's LGPL, to avoid any code license issues I reimplement it
now in my own header. It really looks the same, but putting my application
to LGPL is out of question.

Now I want to be sure that you don't see a copy&paste and remove the license.
Please let me know if this is okay for you.

- Alex

[0] https://github.com/jpirko/libteam/blob/master/libteam/nl_updates.h

On Thu, Sep 04, 2014 at 11:32:49AM +0200, Alexander Aring wrote:
> This header file is needed for additional signed bindings which are not
> in netlink library, currently.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  src/nl_extras.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 src/nl_extras.h
> 
> diff --git a/src/nl_extras.h b/src/nl_extras.h
> new file mode 100644
> index 0000000..39a97c6
> --- /dev/null
> +++ b/src/nl_extras.h
> @@ -0,0 +1,36 @@
> +#ifndef __NL_EXTRAS_H
> +#define __NL_EXTRAS_H
> +
> +#ifndef NLA_S8
> +
> +#define NLA_S8	13
> +#define NLA_PUT_S8(n, attrtype, value) \
> +	NLA_PUT_TYPE(n, int8_t, attrtype, value)
> +
> +#endif /* NLA_S8 */
> +
> +#ifndef NLA_S16
> +
> +#define NLA_S16	14
> +#define NLA_PUT_S16(n, attrtype, value) \
> +	NLA_PUT_TYPE(n, int16_t, attrtype, value)
> +
> +#endif /* NLA_S16 */
> +
> +#ifndef NLA_S32
> +
> +#define NLA_S32	15
> +#define NLA_PUT_S32(n, attrtype, value) \
> +	NLA_PUT_TYPE(n, int32_t, attrtype, value)
> +
> +#endif /* NLA_S32 */
> +
> +#ifndef NLA_S64
> +
> +#define NLA_S64	16
> +#define NLA_PUT_S64(n, attrtype, value) \
> +	NLA_PUT_TYPE(n, int64_t, attrtype, value)
> +
> +#endif /* NLA_S64 */
> +
> +#endif /* __NL_EXTRAS_H */
> -- 
> 2.1.0
> 

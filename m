Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35898 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbbHSOWQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 19 Aug 2015 10:22:16 -0400
Received: by wicja10 with SMTP id ja10so121614144wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 19 Aug 2015 07:22:15 -0700 (PDT)
Date: Wed, 19 Aug 2015 16:22:09 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools] mac: range checking for command accepting
 only 0 or 1
Message-ID: <20150819142147.GA31917@omega>
References: <1439993604-8335-1-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1439993604-8335-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

Hi Stefan,

On Wed, Aug 19, 2015 at 04:13:24PM +0200, Stefan Schmidt wrote:
> lbt and ackreq_default only accept 0or 1 as arguments which we did not
> acount for so far. Testing invalid arguments and checking teh return
> code uncovered this one.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  src/mac.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/src/mac.c b/src/mac.c
> index 76db58f..26c6fc5 100644
> --- a/src/mac.c
> +++ b/src/mac.c
> @@ -175,6 +175,8 @@ static int handle_lbt_mode(struct nl802154_state *state,
>  	mode = strtoul(argv[0], &end, 0);
>  	if (*end != '\0')
>  		return 1;
> +	if (mode != 0 && mode != 1)
> +		return 1;
>  
>  	NLA_PUT_U8(msg, NL802154_ATTR_LBT_MODE, mode);
>  
> @@ -202,6 +204,8 @@ static int handle_ackreq_default(struct nl802154_state *state,
>  	ackreq = strtoul(argv[0], &end, 0);
>  	if (*end != '\0')
>  		return 1;
> +	if (ackreq != 0 && ackreq != 1)
> +		return 1;
>  

range checks should be handled by kernelspace. Currently we do a "!!var"
conversion there. Maybe we should change it there and accept "1" or "0".

We should never handle "if a range is valid or not" inside userspace,
otherwise other applications which talking to nl802154 can do a
different handling then.

- Alex

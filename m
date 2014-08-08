Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:44093 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756339AbaHHLQq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Aug 2014 07:16:46 -0400
Date: Fri, 8 Aug 2014 13:16:39 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140808111637.GA17088@omega>
References: <1407495439-5906-1-git-send-email-varkabhadram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1407495439-5906-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH bluetooth-next] MAINTAINERS: add mailing list
To: varkabhadram@gmail.com
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi Varka,

On Fri, Aug 08, 2014 at 04:27:19PM +0530, varkabhadram@gmail.com wrote:
> From: Varka Bhadram <varkab@cdac.in>
> 
> adds the mailing list address for bluetooth generic 6lowpan and
> 802.15.4 subsystems
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  MAINTAINERS |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 05e5450..59a4108 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -154,6 +154,7 @@ F:	drivers/scsi/53c700*
>  M:	Alexander Aring <alex.aring@gmail.com>
>  L:	linux-zigbee-devel@lists.sourceforge.net (moderated for non-subscribers)
>  L:	linux-bluetooth@vger.kernel.org
> +L:	linux-wpan@vger.kernel.org
>  S:	Maintained
>  F:	net/6lowpan/
>  F:	include/net/6lowpan.h
> @@ -4561,6 +4562,7 @@ F:	drivers/idle/i7300_idle.c
>  IEEE 802.15.4 SUBSYSTEM
>  M:	Alexander Aring <alex.aring@gmail.com>
>  L:	linux-zigbee-devel@lists.sourceforge.net (moderated for non-subscribers)
> +L:	linux-wpan@vger.kernel.org
>  W:	http://apps.sourceforge.net/trac/linux-zigbee
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lowpan/lowpan.git
>  S:	Maintained

ah, okay. Seems that both entries are in bluetooth-next now, so we can
do this.

Please drop the old linux zigbee one and replace the "T:" entry in
IEEE 802.15.4 SUBSYSTEM into:

git git://github.com/linux-wpan/linux-wpan-next.git

also add a "W:" entry for the website:

https://github.com/linux-wpan


and there are several files missing in IEEE 802.15.4 SUBSYSTEM. I want
to do this all of these things in one patch. Please add these missing
files like:

Documentation/networking/ieee802154.txt
include/** <-- search for 802154 stuff



Marcel, maybe we should add:

T: git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git

in 6LOWPAN_GENERIC. Do you agree with that?


Thanks.

- Alex

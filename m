Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37328 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbDLKk4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 12 Apr 2015 06:40:56 -0400
Received: by widdi4 with SMTP id di4so23642532wid.0
        for <linux-wpan@vger.kernel.org>; Sun, 12 Apr 2015 03:40:55 -0700 (PDT)
Received: from omega (p20030064A93D96E6E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a93d:96e6:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id o6sm1660628wiz.24.2015.04.12.03.40.54
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2015 03:40:54 -0700 (PDT)
Date: Sun, 12 Apr 2015 12:40:49 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 wpan-misc] website: add opentask section in developing
Message-ID: <20150412104046.GA3847@omega>
References: <1428833788-3391-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1428833788-3391-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

On Sun, Apr 12, 2015 at 12:16:28PM +0200, Alexander Aring wrote:
> This patch adds an open task section in developing. So maybe if somebody
> has too much time he/she can pick tasks from it and send patches.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  - fix 802.1.54 to 802.15.4
>  - fix ". crypto" to ". Crypto"
>  - add network-manager entry
>  - add socket cleanup/fix entry
> 
>  website/index.txt | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/website/index.txt b/website/index.txt
> index 2f007d5..0a135e2 100644
> --- a/website/index.txt
> +++ b/website/index.txt
> @@ -122,6 +122,31 @@ All patches should be send to <linux-wpan@vger.kernel.org> and based on bluetoot
>  For wpan-tools checkout the https://github.com/linux-wpan/wpan-tools[wpan-tools] repository. Also send patches to <linux-wpan@vger.kernel.org> for it with a "wpan-tools" tag.
>  The same for https://github.com/linux-wpan/wpan-misc[wpan-misc].
>  
> +Open Tasks
> +~~~~~~~~~~
> +
> +* There is a lot of missing features for enum definition to some string definition in iwpan which can be lookup in 802.15.4 standard. Words say more than numbers...
> +** channel/page to frequency
> +** cca modes/opts
> +** no aret mode for max_frame_retires -1
> +** etc
> +* Missing features which wireless has and wpan not. Since we based our implementation on wireless we should sync "good patches" from wireless branch.
> +** Something like http://www.spinics.net/lists/netdev/msg321088.html[net: nl80211 - pass name_assign_type to rdev_add_virtual_intf()]
> +** trace functionality for rdev/driver_ops http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/wireless/rdev-ops.h[rdev-ops.h] and
> +http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac80211/driver-ops.h[driver-ops.h]
> +** Whatever you want and find

Another idea here is to have some command like "iw station dump" ->
"iwpan node dump" which contains all "neighbors" (some table entries
which expires after xx time) and their addresses, lqi value, etc.

This could be useful to offer some "generic interface" for upcomming
metric routing strategies, or whatever you want to do with these
information.

- Alex

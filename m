Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:51186 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbbDKQmT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Apr 2015 12:42:19 -0400
Date: Sat, 11 Apr 2015 18:42:15 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH wpan-misc] website: add opentask section in developing
Message-ID: <20150411164215.GA10163@bogon.m.sigxcpu.org>
References: <1428481894-19784-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1428481894-19784-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Wed, Apr 08, 2015 at 10:31:34AM +0200, Alexander Aring wrote:
> This patch adds an open task section in developing. So maybe if somebody
> has too much time he/she can pick tasks from it and send patches.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  website/index.txt | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/website/index.txt b/website/index.txt
> index 2f007d5..9cf2ca3 100644
> --- a/website/index.txt
> +++ b/website/index.txt
> @@ -122,6 +122,29 @@ All patches should be send to <linux-wpan@vger.kernel.org> and based on bluetoot
>  For wpan-tools checkout the https://github.com/linux-wpan/wpan-tools[wpan-tools] repository. Also send patches to <linux-wpan@vger.kernel.org> for it with a "wpan-tools" tag.
>  The same for https://github.com/linux-wpan/wpan-misc[wpan-misc].
>  
> +Open Tasks
> +~~~~~~~~~~
> +
> +* There is a lot of missing features for enum definition to some string definition in iwpan which can be lookup in 802.1.54 standard. Words say more than numbers...
> +** channel/page to frequency
> +** cca modes/opts
> +** no aret mode for max_frame_retires -1
> +** etc
> +* Missing features which wireless has and wpan not. Since we based our implementation on wireless we should sync "good patches" from wireless branch.
> +** Something like http://www.spinics.net/lists/netdev/msg321088.html[net: nl80211 - pass name_assign_type to rdev_add_virtual_intf()]
> +** trace functionality for rdev/driver_ops http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/wireless/rdev-ops.h[rdev-ops.h] and
> +http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac80211/driver-ops.h[driver-ops.h]

I've started to add some tracing at:

    https://github.com/agx/linux-wpan-next/commits/features/trace

will post the patch here once I've finished the rdev part.
Cheers,
 -- Guido

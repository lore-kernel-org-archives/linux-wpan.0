Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:32930 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbbH3Vpc (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Sun, 30 Aug 2015 17:45:32 -0400
Subject: Re: [RFCv2 bluetooth-next 00/16] ieee802154: 6lowpan: cleanup and
 rework dispatch evaluation
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55E37978.7040101@osg.samsung.com>
Date: Sun, 30 Aug 2015 23:45:28 +0200
MIME-Version: 1.0
In-Reply-To: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 20/08/15 18:47, Alexander Aring wrote:
> Hi,
>
> this patch series contains a rework of 802.15.4 6LoWPAN receive handling.
> We need to check on some things before which never checked before, like
> is 802.15.4 dataframe, if we can access skb->data[0] (could be that skb->len
> is 0 then), etc.
>
> Also various bug fixes like the masking for fragmentation dispatch value which
> is currently wrong. Also we should again check the dispatch value after successful
> reassembly a fragment, we currently assume always a iphc header there. This is wrong
> it could also be a non-compressed header. This can occur if the compressed header is
> larger than lower interface MTU size, we doesn't react on this while transmit which
> is another issue. Nevertheless we also don't reach this case at worst-case compression
> currently.
>
> I introduced a complete new handling for the dispatch values based on mac80211
> receive handling mechanism.

Tested-by: Stefan Schmidt <stefan@osg.samsung.com>

for the whole series as my testing showed no problems.

Going through the patches now reviewing. Skipping all that already have 
my reviewed by tag from the last round.

regards
Stefan Schmidt

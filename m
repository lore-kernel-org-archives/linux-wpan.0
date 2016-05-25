Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35670 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbcEYFNg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 25 May 2016 01:13:36 -0400
Received: by mail-pf0-f170.google.com with SMTP id g64so14632529pfb.2
        for <linux-wpan@vger.kernel.org>; Tue, 24 May 2016 22:13:36 -0700 (PDT)
Subject: Re: [RFC 00/12] 6lowpan: introduce 6lowpan-nd
References: <1464031328-17524-1-git-send-email-aar@pengutronix.de>
From: YOSHIFUJI Hideaki <hideaki.yoshifuji@miraclelinux.com>
Message-ID: <57453479.9080603@miraclelinux.com>
Date: Wed, 25 May 2016 14:13:29 +0900
MIME-Version: 1.0
In-Reply-To: <1464031328-17524-1-git-send-email-aar@pengutronix.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, linux-wpan@vger.kernel.org
Cc: hideaki.yoshifuji@miraclelinux.com, kernel@pengutronix.de, marcel@holtmann.org, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>

Hi.

Alexander Aring wrote:
> Hi,
> 
> this patch series introduces the ndisc ops callback structure to add different
> handling for IPv6 neighbour discovery cache functionality. It implements at first
> the two following use-cases:
> 
>  - 6CO handling as userspace option (For all 6LoWPAN layers, BTLE/802.15.4) [0]
>  - short address handling for 802.15.4 6LoWPAN only [1]
> 
> Since my last patch series, I completely changed the whole ndisc_ops callback
> structure to not replace the whole ndisc functionality at recv/send level of
> NS/NA/RS/RA which I send in my previous patch-series "6lowpan: introduce basic
> 6lowpan-nd". I changed it now to add different handling in a very low-level way
> of ndisc functionality.

Thank you for your work!  It looks much better now.
Some comments will follow.

-- 
Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>
Technical Division, MIRACLE LINUX CORPORATION

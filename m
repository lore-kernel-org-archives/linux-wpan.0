Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:56647 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbbE1JAf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 05:00:35 -0400
Received: from itwm2.itwm.fhg.de (itwm2.itwm.fhg.de [131.246.191.3])
	by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-7) with ESMTP id t4S90Vx4023425
	for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 11:00:31 +0200
Date: Thu, 28 May 2015 11:00:26 +0200
From: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Subject: Re: 802.15.4 security
Message-ID: <20150528110026.70a44e0d@zoidberg>
In-Reply-To: <555DDC3E.6090203@xsilon.com>
References: <555DDC3E.6090203@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi Simon,

sorry for taking so long to reply. Unfortunately, there's currently no
actual documentation for the crypto layer (and I probably won't come
around to write any sometime soon), but I have built an application
that works with llsec [1].

The process to set up a crypto config for a network is rougly outlined
in [2] and [3]. There are more options to the crypto layer than are used
there, but the process is pretty much the same: you add a number of
devices you want to securely communicate with, add the keys those
devices will use to communicate, and then set the general parameters
for llsec (like default llsec, enabling the crypto layer and such).

Hope that helps a little,
Phoebe


[1]
https://github.com/mysmartgrid/hexabus/blob/pb-crypto/hostsoftware/hxbnm
[2]
https://github.com/mysmartgrid/hexabus/blob/pb-crypto/hostsoftware/hxbnm/src/hxbnm.cpp#L160
[3]
https://github.com/mysmartgrid/hexabus/blob/pb-crypto/hostsoftware/hxbnm/src/hxbnm.cpp#L90

On Thu, 21 May 2015 14:23:10 +0100
Simon Vincent <simon.vincent@xsilon.com> wrote:

> What is the status of the crypto-layer? I can see a lot of crypto 
> functionality in the mac layer but I can't work out how to setup the 
> keys and enable encryption/authentication. Will this be part of the 
> wpan-tools?
> 
> - Simon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


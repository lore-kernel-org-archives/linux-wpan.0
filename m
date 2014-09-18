Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:52799 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755755AbaIRKEp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 06:04:45 -0400
Message-ID: <541AAE3A.80306@xsilon.com>
Date: Thu, 18 Sep 2014 11:04:42 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: Promiscuous patches
References: <5412F199.7010803@xsilon.com> <20140914234551.GA7009@omega> <541A9E65.3090300@xsilon.com> <20140918094123.GA4350@omega>
In-Reply-To: <20140918094123.GA4350@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

If I'm following correctly you need to add a monitor interface as well as a node/coord interface to the PHY.  so we would see wpan0 and wpanmon0 and then I could do a
tcpdump -i wpanmon0?

- Martin.

On 18/09/14 10:41, Alexander Aring wrote:
> In promiscuous mode, the phy interrupts on any frame which is received,
> you don't have any address filtering mac functionality on the phy
> anymore. That means you have only the linux mac802154 address filtering
> functionality running. That means the phy doesn't filter anymore and you
> get really all frames and the internal mac802154 filter drops the
> packets.
>
> To enable promiscuous mode on a wpan/node type makes no sense. To enables
> promiscuous mode on MONITOR makes, sense. On  MONITOR type we don't run
> any mac802154 address filtering and you will get any frame on the
> monitor interface.
>
>
> I hope it's understandable what I mean here a little bit.


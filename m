Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:53738 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886AbaIRKnb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 06:43:31 -0400
Received: by mail-we0-f169.google.com with SMTP id w61so689666wes.14
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 03:43:30 -0700 (PDT)
Date: Thu, 18 Sep 2014 12:43:24 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Promiscuous patches
Message-ID: <20140918104322.GA5217@omega>
References: <5412F199.7010803@xsilon.com>
 <20140914234551.GA7009@omega>
 <541A9E65.3090300@xsilon.com>
 <20140918094123.GA4350@omega>
 <541AAE3A.80306@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541AAE3A.80306@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Sep 18, 2014 at 11:04:42AM +0100, Martin Townsend wrote:
> Hi Alex,
> 
> If I'm following correctly you need to add a monitor interface as well as a node/coord interface to the PHY.  so we would see wpan0 and wpanmon0 and then I could do a
> tcpdump -i wpanmon0?
> 

mhhh, no.

It's a question of design to have NODE, COORD and MONITOR parallel.

But when we have phy mac handling for a iftype we should not have this
parallel.

We have multiple interfaces support, BUT only ONE phy.

The phy have also mac handling, like addressfilter XOR promiscousmode.

The addressfilter doesn't interrupt the phy on ANY frame, only on frames
which belongs to us (the phy). That's why addressfilter makes sense on NODE and COORD.
After an interrupt the LINUX mac802154 stack also run a addressfilter to
be sure. (BUT only on NODE and COORD types).

The MONITOR type bypass the mac802154 filters and send any frame to the
interface, then you can see it on wireshark. But this required to
disable the addressfilter of mac phy handling -> promiscousmode.

Now having NODE and MONITOR parallel, you can't have promiscousmode and
addressfilter at the same time. promiscousmode disabled the
addressfilter. But then the LINUX mac802154 have a very workload because
it need to check any frame which is received on promiscousmode. This
isn't pracitcal, also promiscousmode isn't only addressfiltering also
CRC...


When you enable the promiscousmode on WPAN/NODE interface you only
enable that your cpu load increases because you don't have any phy
addressfilter anymore, then mac802154 do the job for you and remember a
MONITOR device bypass the mac802154 filtering, then you see ONLY on a
MONITOR interface every frame. Also frames which not in your pan or doesn'
belong to you. That's what's the monitor interface does.


More understandable? :/

- Alex

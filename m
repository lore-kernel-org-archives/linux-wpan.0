Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:56561 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbaIRMAg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 08:00:36 -0400
Message-ID: <541AC962.7090301@xsilon.com>
Date: Thu, 18 Sep 2014 13:00:34 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: Promiscuous patches
References: <5412F199.7010803@xsilon.com> <20140914234551.GA7009@omega> <541A9E65.3090300@xsilon.com> <20140918094123.GA4350@omega> <541AAE3A.80306@xsilon.com> <20140918104322.GA5217@omega>
In-Reply-To: <20140918104322.GA5217@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

On 18/09/14 11:43, Alexander Aring wrote:
> On Thu, Sep 18, 2014 at 11:04:42AM +0100, Martin Townsend wrote:
>> Hi Alex,
>>
>> If I'm following correctly you need to add a monitor interface as well as a node/coord interface to the PHY.  so we would see wpan0 and wpanmon0 and then I could do a
>> tcpdump -i wpanmon0?
>>
> mhhh, no.
>
> It's a question of design to have NODE, COORD and MONITOR parallel.
>
> But when we have phy mac handling for a iftype we should not have this
> parallel.
>
> We have multiple interfaces support, BUT only ONE phy.
>
> The phy have also mac handling, like addressfilter XOR promiscousmode.
>
> The addressfilter doesn't interrupt the phy on ANY frame, only on frames
> which belongs to us (the phy). That's why addressfilter makes sense on NODE and COORD.
> After an interrupt the LINUX mac802154 stack also run a addressfilter to
> be sure. (BUT only on NODE and COORD types).
>
> The MONITOR type bypass the mac802154 filters and send any frame to the
> interface, then you can see it on wireshark. But this required to
> disable the addressfilter of mac phy handling -> promiscousmode.
>
> Now having NODE and MONITOR parallel, you can't have promiscousmode and
> addressfilter at the same time. promiscousmode disabled the
> addressfilter. But then the LINUX mac802154 have a very workload because
> it need to check any frame which is received on promiscousmode. This
> isn't pracitcal, also promiscousmode isn't only addressfiltering also
> CRC...
Is monitor mode like the one in WIFI (rfmon)
http://en.wikipedia.org/wiki/Monitor_mode
Where it can't transmit packets, it basically turns the device into a packet sniffer?
>
> When you enable the promiscousmode on WPAN/NODE interface you only
> enable that your cpu load increases because you don't have any phy
> addressfilter anymore, then mac802154 do the job for you and remember a
> MONITOR device bypass the mac802154 filtering, then you see ONLY on a
> MONITOR interface every frame. Also frames which not in your pan or doesn'
> belong to you. That's what's the monitor interface does.
>
>
> More understandable? :/
Basically I want to be able to run tcpdump on wpan0 to capture packets but not effect the functionality of device so if it's a node or coordinator it carries on acting like one and the packet traffic capture would reflect this.  So if I'm running as a coordinator and want to see RPL traffic that the coordinator generates and receives I can do this.
My understanding is that I put the WPAN interface into promiscuous mode to do this.  I accept that the CPU will come under more load but we are only talking about a 256kbps link.  If you a running a linux distribution chances are you are using a fairly powerful ARM or equivalent processor.
Are we saying this is not possible?

> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

- Martin.

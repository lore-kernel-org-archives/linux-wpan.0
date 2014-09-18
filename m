Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:55747 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159AbaIRNed (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 09:34:33 -0400
Received: by mail-we0-f169.google.com with SMTP id w61so939563wes.0
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 06:34:32 -0700 (PDT)
Date: Thu, 18 Sep 2014 15:34:26 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Promiscuous patches
Message-ID: <20140918133424.GA8458@omega>
References: <20140914234551.GA7009@omega>
 <541A9E65.3090300@xsilon.com>
 <20140918094123.GA4350@omega>
 <541AAE3A.80306@xsilon.com>
 <20140918104322.GA5217@omega>
 <541AC962.7090301@xsilon.com>
 <20140918122140.GA6777@omega>
 <20140918123024.GB6777@omega>
 <20140918124430.GA8268@omega>
 <541ADD3B.8090706@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541ADD3B.8090706@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Sep 18, 2014 at 02:25:15PM +0100, Martin Townsend wrote:
> 
> On 18/09/14 13:44, Alexander Aring wrote:
> > On Thu, Sep 18, 2014 at 02:30:24PM +0200, Alexander Aring wrote:
> >> On Thu, Sep 18, 2014 at 02:21:40PM +0200, Alexander Aring wrote:
> >> ...
> >>> I think you only want to have a wireshark on a interface.
> >>>
> >>> wireshark/tcpdump whatever tolds you that the device is into
> >>> promiscousmode. But this doesn't change anything also for wireless
> >>> (802.11) because the multiple interface types, it's hard to handle it to change
> >>> this during runtime. This is some historial issue when you don't have
> >>> interface types like ethernet.
> >>>
> >>>
> >>> I think we need to clarify that promiscousmode in a NODE/COORD makes no
> >>> sense.
> >>>
> >>> In userspace what you receive via wireshark/tcpdump makes no different
> >>> (should not do any different) if you are in promiscousmode or not. Because
> >>> the mac802154 filter packets like when the phy mac filters is
> >>> activated.
> >>>
> >>> If you have a MONITOR type, there is no mac802154 filter activated. And
> >>> I mean with mac802154 the stack implementation of Linux kernel.
> >>>
> >>>
> >>> Repeat:
> >>>
> >>> If you have promiscousmode and NODE/COORD then you only increase the cpu
> >>> load and there is (should) no different in userspace by capture with
> >>> wireshark/tcpdump. You don't get more frames behind the mac802154 filter.
> >>>
> >>> On MONITOR type this differs, because you don't have the mac802154 filter.
> >>>
> >>>
> >>> Or I don't understand 100% what you meant here, sorry.
> >>>
> >> I read now description of [0].
> >>
> >> And now what 802.15.4-2011 says about the promiscousmode:
> >>
> >> The second level of filtering shall be dependent on whether the MAC sublayer is currently operating in
> >> promiscuous mode. In promiscuous mode, the MAC sublayer shall pass all frames received after the first
> >> filter directly to the upper layers without applying any more filtering or processing. The MAC sublayer shall
> >> be in promiscuous mode if macPromiscuousMode is set to TRUE.
> >>
> >> There is lot of other description "simple disable all filtering". There
> >> is no word about association with pan'ss.
> >>
> >> This is for me the MONITOR mode. So MAYBE we could make some MONITOR
> >> type which can associated with a PAN and then this can only show PAN
> >> traffic. But when we can do this, when we support association with
> >> pan's. :-) Then it's like promiscousmode what's desribed at [0].
> >>
> > or simple change the wireshark filters that you only get frames with
> > panid 0xbeef, or something else.
> >
> > MONITOR and promiscousmode according 802.15.4-2011 simple means, disable
> > filtering for me. :/
> >
> > I really not sure about that I understand what you want to do now with
> > promiscousmode.
> I want to be able from COORD or NODE mode to put the device in promiscuous mode so packets can be received by wireshark.  For example if we are seeing a problem on a device, I want to be able to ssh into this node via Ethernet (or maybe connect via the serial console) and run tcpdump -U -i wpan0 to help debugging by seeing what packets are being sent/received.  As it's going to stdout it will be sent over ssh and I can then do some pipe redirection to pipe it into Wireshark running on a different machine.
> 
> From my understanding this is not MONITOR mode and I don't won't to put the device into MONITOR mode as this could effect it's functionality.
> I'm currently looking at how tcpdump does this and it looks like it uses a raw socket using PF_PACKET.  I think it then sets the IFF_PROMISC flag on this socket to put the device into promiscuous mode.  As I'm in COORD or NODE mode this will arrive at the ndo_change_rx_flags for the net device ops defined in wpan.c not monitor.c in my linux tree.
> 
> I notice in your linux-wpan-next alex/wip branch there is no wpan.c or monitor.c, and I can't see how I can be a COORD or NODE and capture packets.
> 

Then you simple need to rum wireshark/tcpdump etc.

I use:

"ssh root@$IP 'tshark -i wpan0 -w -' | wireshark -k -i -"

replace $IP with $IP of ethernet 802.15.4 node. Then you only see frames
with filtering and belongs to you and whatever any interface capture then.
Require ssh on both, tshark on target and wireshark on host.


What we talking about is promiscousmode setting according 802.15.4-2011.
With that you don't need to set any register setting, just start
capturing the interface. Also no special handling for IFF_PROMISC is
needed.

- Alex

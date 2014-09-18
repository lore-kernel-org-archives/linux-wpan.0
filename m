Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:50020 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbaIRMoj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 08:44:39 -0400
Received: by mail-wi0-f177.google.com with SMTP id em10so1112570wid.16
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 05:44:38 -0700 (PDT)
Date: Thu, 18 Sep 2014 14:44:30 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Promiscuous patches
Message-ID: <20140918124430.GA8268@omega>
References: <5412F199.7010803@xsilon.com>
 <20140914234551.GA7009@omega>
 <541A9E65.3090300@xsilon.com>
 <20140918094123.GA4350@omega>
 <541AAE3A.80306@xsilon.com>
 <20140918104322.GA5217@omega>
 <541AC962.7090301@xsilon.com>
 <20140918122140.GA6777@omega>
 <20140918123024.GB6777@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140918123024.GB6777@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Sep 18, 2014 at 02:30:24PM +0200, Alexander Aring wrote:
> On Thu, Sep 18, 2014 at 02:21:40PM +0200, Alexander Aring wrote:
> ...
> > 
> > I think you only want to have a wireshark on a interface.
> > 
> > wireshark/tcpdump whatever tolds you that the device is into
> > promiscousmode. But this doesn't change anything also for wireless
> > (802.11) because the multiple interface types, it's hard to handle it to change
> > this during runtime. This is some historial issue when you don't have
> > interface types like ethernet.
> > 
> > 
> > I think we need to clarify that promiscousmode in a NODE/COORD makes no
> > sense.
> > 
> > In userspace what you receive via wireshark/tcpdump makes no different
> > (should not do any different) if you are in promiscousmode or not. Because
> > the mac802154 filter packets like when the phy mac filters is
> > activated.
> > 
> > If you have a MONITOR type, there is no mac802154 filter activated. And
> > I mean with mac802154 the stack implementation of Linux kernel.
> > 
> > 
> > Repeat:
> > 
> > If you have promiscousmode and NODE/COORD then you only increase the cpu
> > load and there is (should) no different in userspace by capture with
> > wireshark/tcpdump. You don't get more frames behind the mac802154 filter.
> > 
> > On MONITOR type this differs, because you don't have the mac802154 filter.
> > 
> > 
> > Or I don't understand 100% what you meant here, sorry.
> > 
> 
> I read now description of [0].
> 
> And now what 802.15.4-2011 says about the promiscousmode:
> 
> The second level of filtering shall be dependent on whether the MAC sublayer is currently operating in
> promiscuous mode. In promiscuous mode, the MAC sublayer shall pass all frames received after the first
> filter directly to the upper layers without applying any more filtering or processing. The MAC sublayer shall
> be in promiscuous mode if macPromiscuousMode is set to TRUE.
> 
> There is lot of other description "simple disable all filtering". There
> is no word about association with pan'ss.
> 
> This is for me the MONITOR mode. So MAYBE we could make some MONITOR
> type which can associated with a PAN and then this can only show PAN
> traffic. But when we can do this, when we support association with
> pan's. :-) Then it's like promiscousmode what's desribed at [0].
> 

or simple change the wireshark filters that you only get frames with
panid 0xbeef, or something else.

MONITOR and promiscousmode according 802.15.4-2011 simple means, disable
filtering for me. :/

I really not sure about that I understand what you want to do now with
promiscousmode.

- Alex

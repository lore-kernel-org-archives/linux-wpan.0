Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55915 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbbKPPL3 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 16 Nov 2015 10:11:29 -0500
Subject: Re: LL address and IPv6 address
References: <CAPpUg6NwiRzUMEPGpZa3=Ppg3LF3N7u1=o_sA0+rp5aHt0CC9g@mail.gmail.com>
 <CAF4BF-TStucwTg5Kp+YAN735RNQUA+aLf1fEPRKW7uSNZXSKYw@mail.gmail.com>
 <CAPpUg6Pi3Z3fPsDX3EBYhfn96ZLgXxQ5TAYAr7Rk3MKHcoZqxA@mail.gmail.com>
 <CAPpUg6O65Uyy+rhOdqh-cKK_w-4SqPvi9Ho6AGBFD7xUq4hukw@mail.gmail.com>
 <20151112085333.GA3045@omega>
 <CAPpUg6P259rf9NXGpDXqNq2Qragc5Ht9ZvQCSaDGSG1vSWcbZg@mail.gmail.com>
 <25991.1447437856@sandelman.ca> <20151114103526.GB1652@omega>
 <5649EC63.5000508@osg.samsung.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <5649F21D.4090008@osg.samsung.com>
Date: Mon, 16 Nov 2015 16:11:25 +0100
MIME-Version: 1.0
In-Reply-To: <5649EC63.5000508@osg.samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello.

On 16/11/15 15:46, Stefan Schmidt wrote:
>
> There is at least one 802.15.4 IP block out there that markets the 
> support for dual PAN ID.
>
> http://www.freescale.com/products/arm-processors/kinetis-cortex-m/w-series/kinetis-kw2x-2.4-ghz-rf-analog-mixed-signal-ieee-802.15.4-low-power-microcontrollers-mcus:KW2x 
>
>
> So far this is only inside a wireless mcu combination and thus 
> unrealted to us but maybe the IP block will be used in some other 
> hardware later.
>
> What I don't know is how this functionality is exposed by the 
> hardware. Would it only have a few extra regs needed for the dual PAN 
> setup or two full register sets? Would it have different regs for the 
> two sets of address filters? Allowing to have the two PANs on 
> different channels or only on one?

I just browsed to the data sheat to understand what they will provide 
and it boils down to regs for channel, short address, extended address, 
PAN ID and coordinator bit. A timer can be configured by software and/or 
driven by the hardware directly as to when switch between these two.

regards
Stefan Schmidt


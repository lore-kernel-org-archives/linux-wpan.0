Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57437 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751070AbaIWDwM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 22 Sep 2014 23:52:12 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by gateway2.nyi.internal (Postfix) with ESMTP id 32581209BB
	for <linux-wpan@vger.kernel.org>; Mon, 22 Sep 2014 23:52:12 -0400 (EDT)
Message-ID: <5420EE4F.5000007@signal11.us>
Date: Mon, 22 Sep 2014 23:51:43 -0400
From: Alan Ott <alan@signal11.us>
MIME-Version: 1.0
Subject: Re: [PATCH wpan-next] ieee802154: mrf24j40: support for external
 rx/tx
References: <1410759338-21663-1-git-send-email-wmack@componentsw.com> <20140916070156.GB1244@omega> <541899D8.4020101@componentsw.com> <20140916202000.GF6104@omega>
In-Reply-To: <20140916202000.GF6104@omega>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Walter Mack <wmack@componentsw.com>
Cc: linux-wpan@vger.kernel.org, simon.vincent@xsilon.com

On 09/16/2014 04:20 PM, Alexander Aring wrote:
> Hi Walter,
>
> On Tue, Sep 16, 2014 at 01:13:12PM -0700, Walter Mack wrote:
>> Alex,
>>
>> this is not a question of chip revisions. Chips with the same revision can
>> be used in designs with or without the external transmitter/receiver. Its
>> just that the chip has to be set up to be compatible with the design.
>>
> ah, ok. Dunno, I will wait on alan's opinion. If I don't heard anything in one
> week I will apply it.

Did Simon's patch get applied? I couldn't see it in any of the obvious 
places when I looked the other day.

>
> Maybe alan wants also add a device tree support for this driver and then we could
> make a dt property/platform data for that. But for now, I am also fine with module
> parameter solution... because we don't have a dt support right now.
>

I don't like this as a module parameter. That's not what module params 
are really designed for. It's better as DT so that it can be turned on 
and off for the individual devices, not system-wide.

mrf24j40 loads up fine under DT. There just isn't anything to configure 
(so far) other than the SPI.

Are there any other known boards which use the external amplifier 
besides the MB and MC (and MD and ME, which are the same as the MB and MC)?

Alex, I'm not sure how this fits with Simon's patch, as I haven't 
investigated it fully. I'd expect both implementations to be the same, 
but they're not.

Alan.


Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33971 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934069AbcHEJTA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Aug 2016 05:19:00 -0400
Subject: Re: [RFC bluetooth-next 00/20] bluetooth: rework 6lowpan
 implementation
References: <20160711195044.25343-1-aar@pengutronix.de>
 <2D2C7A7559A21B4EAB6B76FE23E27DFA0221FF4FB6@mbx04.nvlsi.no>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <74a09ed9-80bd-d216-8036-3c5bd641bd81@pengutronix.de>
Date: Fri, 5 Aug 2016 11:18:50 +0200
MIME-Version: 1.0
In-Reply-To: <2D2C7A7559A21B4EAB6B76FE23E27DFA0221FF4FB6@mbx04.nvlsi.no>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Bakke, Glenn Ruben" <Glenn.Ruben.Bakke@nordicsemi.no>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "kaspar@schleiser.de" <kaspar@schleiser.de>, "jukka.rissanen@linux.intel.com" <jukka.rissanen@linux.intel.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "Patrik.Flykt@linux.intel.com" <Patrik.Flykt@linux.intel.com>


Hi,

On 08/05/2016 09:15 AM, Bakke, Glenn Ruben wrote:
> Hi Alex,
> 
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>>
...
>> --
>> 2.9.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
> 
> I have tested the patch series with all 20 patches and verified that I can connect to devices and communicate between them over IPv6. Multicast and unicast where tested.
> The neighbors where manually added with the command "ip -6 neigh". However I did not do a long run or thoroughly test, but did the basic verification.
> I really liked the way the HCI device was manually selected for the interface, giving me flexibility to choose what connections I wanted on a given HCI device.
> 

thank you for testing it.

The "ip -6 neigh" command for adding neighbours should not be needed,
why did you do that?

Also the most important information for me would be:

- Did it ever crashed your kernel?
- Do you also have the tx credits deadlock?

I have locally a RFCv2 where I put now these things which I got from
this RFC as suggestion, which are:

 - try to solve that dev->dev_addr is set when first connection is
   there and remove dev_addr when last connection is gone.

   I solved this by creating the interface with address 0...0 at first.
   If there comes a connection in then the address will be set and the
   interface comes up.

   If the last connection will be close (for what reason ever) then the
   interface comes down and the address is 0...0.

   It's not possible to set the interface up when the address is 0...0.

   This behaviour is somewhat better than recreating new interface (in
   my opinion).

 - 6lo%d interface will be created when power on the hci interface and
   deleted when power off. (That's a suggestion from Marcel, so far I
   understood it).

   I implemented it now that "6lowpan_enable" need to be set to "1"
   before setting hci will be powered on. All hci will create an
   interface then.

   This change has a ?nice? effekt that we don't need to close all
   connection when doing a interface unregister.

 - Changed the "6lowpan_control" per hci, not per interface. Which is
   more what Partrik's UAPI draft.

These three things did I change now, I just need to create new patches
and send it to the mailinglist.

But the tx credits deadlock still exists on my side.

- Alex

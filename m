Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx6.haw-public.haw-hamburg.de ([141.22.6.3]:57507 "EHLO
	mx6.haw-public.haw-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750993AbcDGU3t (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Apr 2016 16:29:49 -0400
From: Peter Kietzmann <peter.kietzmann@haw-hamburg.de>
Subject: UDP stress-testing
Message-ID: <5706C0D7.1040000@haw-hamburg.de>
Date: Thu, 7 Apr 2016 22:19:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Dear list,

first of all let me say that I'm new to this list. So if I'm completely 
wrong in my concern please excuse the noise and guide me to the right 
place. If you can :-)!

For some experiments I'm trying to send "great" numbers of UDP packets 
with "great" payloads as fast as possible from a RasPi equipped with the 
Openlabs transceiver. With another RasPi+transceiver I'm sniffing the 
traffic. It turns out that just the first x packets are sent out 
correctly before the outgoing packets come out irregularly. The number 
of correctly sent packets depends on the UDP payload size and it looks 
like the problem occurs after ~30-35 kB Bytes (gross) in total have been 
transmitted (fragmentation overhead included). I already increased the 
send socket memory to a reasonably high value, without success. But 
still I assume some buffer problems. Do you have a hint which screw to 
adjust?

BTW: Introducing a delay after each packet to send fixes the problem. 
But I'd like to do stress-testing...

Best
Peter

-- 
Peter Kietzmann

Hamburg University of Applied Sciences
Dept. Informatik, Internet Technologies Group
Berliner Tor 7, 20099 Hamburg, Germany
Fon: +49-40-42875-8426
Web: http://www.haw-hamburg.de/inet

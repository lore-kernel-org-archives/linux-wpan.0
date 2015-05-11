Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:37091 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbbEKTus (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 11 May 2015 15:50:48 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: testing and building for RPI
Date: Mon, 11 May 2015 15:41:38 -0400
Message-ID: <19096.1431373298@sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: unstrung-hackers <unstrung-hackers@lists.sandelman.ca>


I ordered the 802.15.4 module for PI's GPIO pins from:
  http://openlabs.co/OSHW/Raspberry-Pi-802.15.4-radio

got two of them last week, and I dug the RPI out from behind the
TV. (rasbmc.. nice idea, too slow for me)

I haven't yet gotten to caring if I got the right dtbs file,
as discussed here:
   http://forum.openlabs.co/general-oshw-discussion/6lowpan-kernel-on-rpi/

The current linux-wpan-next tree is based on 4.1-rc1, while it
seems that the rpi kernel patches are not merged yet, and rpi-4.0
is based upon 4.0.1.  I tried rebasing the rpi code upon 4.1-rc1
(with linux-wpan-next), but there were two non-trivial merge errors,
and even when I think I got them, some code fails to compile.
I could share that tree with someone if they wanted to help,
as RPI is gonna have to rebase upon 4.1 at some point.

So, I plan to try the opposite, which is to rebase linux-wpan-next
upon 4.0.1.  I imagine that perhaps there is a tree that I've missed
(or isn't tagged) which was before 4.1-rc1 came out... perhaps not.

The question is therefore: have there been any changes in linux-wpan-next
that got accepted into 4.1, and therefore would be missing if I do a
naive cherry-pick?

Will I have to do some dtbs hacking?

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


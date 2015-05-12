Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34620 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbbELDxC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 11 May 2015 23:53:02 -0400
Received: by pacyx8 with SMTP id yx8so129442633pac.1
        for <linux-wpan@vger.kernel.org>; Mon, 11 May 2015 20:53:01 -0700 (PDT)
Message-ID: <55517906.2060204@gmail.com>
Date: Tue, 12 May 2015 09:22:38 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: testing and building for RPI
References: <19096.1431373298@sandelman.ca>
In-Reply-To: <19096.1431373298@sandelman.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>, linux-wpan@vger.kernel.org
Cc: unstrung-hackers <unstrung-hackers@lists.sandelman.ca>

On 05/12/2015 01:11 AM, Michael Richardson wrote:

> I ordered the 802.15.4 module for PI's GPIO pins from:
>   http://openlabs.co/OSHW/Raspberry-Pi-802.15.4-radio
>
> got two of them last week, and I dug the RPI out from behind the
> TV. (rasbmc.. nice idea, too slow for me)
>
> I haven't yet gotten to caring if I got the right dtbs file,
> as discussed here:
>    http://forum.openlabs.co/general-oshw-discussion/6lowpan-kernel-on-rpi/
>
> The current linux-wpan-next tree is based on 4.1-rc1, while it
> seems that the rpi kernel patches are not merged yet, and rpi-4.0
> is based upon 4.0.1.  I tried rebasing the rpi code upon 4.1-rc1
> (with linux-wpan-next), but there were two non-trivial merge errors,
> and even when I think I got them, some code fails to compile.
> I could share that tree with someone if they wanted to help,
> as RPI is gonna have to rebase upon 4.1 at some point.
>
> So, I plan to try the opposite, which is to rebase linux-wpan-next
> upon 4.0.1.  I imagine that perhaps there is a tree that I've missed
> (or isn't tagged) which was before 4.1-rc1 came out... perhaps not.
>
> The question is therefore: have there been any changes in linux-wpan-next
> that got accepted into 4.1, and therefore would be missing if I do a
> naive cherry-pick?
>
> Will I have to do some dtbs hacking?
>
You can directly use linux-wpan-next tree directly, which has the basic
support for RPI. No need to rebase it on rpi kernel.

Please see the blog: https://honk.sigxcpu.org/piki/hw/rpi6lowpan/

Thanks.
-- 
Varka Bhadram


Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:42391 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbbFKIXN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 11 Jun 2015 04:23:13 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Strategy for permament extended/EUI64 address writing and updating in atusb
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150611081745.GB972@omega>
Date: Thu, 11 Jun 2015 10:23:09 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <CB3536CD-EEC2-48C8-8C52-212B3A6BDEC3@holtmann.org>
References: <55782D54.2030508@osg.samsung.com> <00F27E6C-BEA0-42C5-8AF4-06A3CCEE320F@holtmann.org> <20150610152925.GD6647@omega> <20150610212351.GS5054@ws> <20150611081745.GB972@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Werner Almesberger <werner@almesberger.net>, Stefan Schmidt <stefan@osg.samsung.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>

Hi Alex,

>>> I think the endpoint 0 is different between bootloader (dfu) and the
>>> application (atusb). Maybe then add this functionality for the
>>> bootloader only.
>> 
>> If you add it to the boot loader, then you need to flash your
>> enhanced boot loader via in-circuit programming (or find a way
>> to bypass the write protection. NB: no such way should exist.)
>> Not everyone may find that convenient ;)
>> 
>> I'd leave the boot loader as it is and just add a new operation
>> to the application part of the firmware.
>> 
> 
> yea, this was just an idea because Marcel said:
> 
> "... you might want to push that device into a special mode to allow
> programming of these settings"
> 
> and that's for me the dfu mode. My idea was just make the "new
> operation" accessable in dfu endpoint only.
> 
> Nevertheless I am also fine with normal application operation, or making
> some special bus access cycles to get into "privileged mode" or
> something else, everything is possible.

I would not do that at runtime mode unless you have an easy way to re-enmuerate that device. Reason is that changing settings like the address should be only be done when the device is in a special mode.

So at minimum that needs to be when the device is powered off or something. And if you change the address it re-enumerates again so that userspace can know that the address has changed.

For a permanent address, that is normally done in a special mode when you provision it. Be that DFU mode or some other mode you push the device into.

Regards

Marcel


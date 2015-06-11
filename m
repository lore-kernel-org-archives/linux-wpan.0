Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from host.almesberger.net ([204.10.140.10]:54084 "EHLO
	host.almesberger.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbbFKQOa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 11 Jun 2015 12:14:30 -0400
Date: Thu, 11 Jun 2015 13:14:09 -0300
From: Werner Almesberger <werner@almesberger.net>
Subject: Re: Strategy for permament extended/EUI64 address writing and
 updating in atusb
Message-ID: <20150611161409.GU5054@ws>
References: <55782D54.2030508@osg.samsung.com>
 <00F27E6C-BEA0-42C5-8AF4-06A3CCEE320F@holtmann.org>
 <20150610152925.GD6647@omega>
 <20150610212351.GS5054@ws>
 <20150611081745.GB972@omega>
 <CB3536CD-EEC2-48C8-8C52-212B3A6BDEC3@holtmann.org>
 <55795759.8060306@osg.samsung.com>
 <20150611124816.GT5054@ws>
 <55798F76.8020708@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55798F76.8020708@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Alexander Aring <alex.aring@gmail.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>

Stefan Schmidt wrote:
>    o It read the EUI64 from EEPROM during probe and is no further
> touching it at all

That's then functionally equivalent to the "copying to RAM"
I proposed.

>    o Furthermore, after the EEPROM write a mcu_reset() done to
> re-enumerate on the USB bus

I'm just saying that we already have a generic mechanism for
getting the device to re-enumerate.

> Not compelling at all if you ask me. We have an EEPROM
> available to store such device properties so we better use it.

While I disagree with any reasoning that one should use the
EEPROM because it's there, I also think that attaching the
address to the firmware binary would add too many operational
complications.

- Werner

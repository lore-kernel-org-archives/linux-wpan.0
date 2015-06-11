Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from host.almesberger.net ([204.10.140.10]:53987 "EHLO
	host.almesberger.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbbFKMsk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 11 Jun 2015 08:48:40 -0400
Date: Thu, 11 Jun 2015 09:48:16 -0300
From: Werner Almesberger <werner@almesberger.net>
Subject: Re: Strategy for permament extended/EUI64 address writing and
 updating in atusb
Message-ID: <20150611124816.GT5054@ws>
References: <55782D54.2030508@osg.samsung.com>
 <00F27E6C-BEA0-42C5-8AF4-06A3CCEE320F@holtmann.org>
 <20150610152925.GD6647@omega>
 <20150610212351.GS5054@ws>
 <20150611081745.GB972@omega>
 <CB3536CD-EEC2-48C8-8C52-212B3A6BDEC3@holtmann.org>
 <55795759.8060306@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55795759.8060306@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Alexander Aring <alex.aring@gmail.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>

Stefan Schmidt wrote:
> 2) The firmware can issue a MCU reset after the address was written
> which would force a USB reset and re-enumerate.

Or just copy EEPROM content to RAM on application start ("reset")
and on USB bus reset, and make the application that writes the
EEPROM do a USB bus reset.

That way, the address won't change while the device is in active
use, no matter how often you write to the EEPROM. And a USB bus
reset is supposed to reset the whole dependency chain anyway, so
that should be a safe moment for propagating the address change.

Oh, and for completeness, a plan B could be to attach the address
to the application binary (so you read it from Flash, not EEPROM).
Then you could use DFU. But you'd be trading one can of worms for
another one.

> The perfect solution would be to have this done [...]

Yup, once time travel finally becomes mainstream, engineers will
laugh about our clumsy work-arounds ;-)

- Werner

Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from host.almesberger.net ([204.10.140.10]:53651 "EHLO
	host.almesberger.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbFJVYU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Jun 2015 17:24:20 -0400
Date: Wed, 10 Jun 2015 18:23:51 -0300
From: Werner Almesberger <werner@almesberger.net>
Subject: Re: Strategy for permament extended/EUI64 address writing and
 updating in atusb
Message-ID: <20150610212351.GS5054@ws>
References: <55782D54.2030508@osg.samsung.com>
 <00F27E6C-BEA0-42C5-8AF4-06A3CCEE320F@holtmann.org>
 <20150610152925.GD6647@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150610152925.GD6647@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Stefan Schmidt <stefan@osg.samsung.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>

Alexander Aring wrote:
> I think the endpoint 0 is different between bootloader (dfu) and the
> application (atusb). Maybe then add this functionality for the
> bootloader only.

If you add it to the boot loader, then you need to flash your
enhanced boot loader via in-circuit programming (or find a way
to bypass the write protection. NB: no such way should exist.)
Not everyone may find that convenient ;)

I'd leave the boot loader as it is and just add a new operation
to the application part of the firmware.

- Werner

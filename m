Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33779 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbbFKIRx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 11 Jun 2015 04:17:53 -0400
Received: by wiwd19 with SMTP id d19so67588786wiw.0
        for <linux-wpan@vger.kernel.org>; Thu, 11 Jun 2015 01:17:52 -0700 (PDT)
Date: Thu, 11 Jun 2015 10:17:49 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Strategy for permament extended/EUI64 address writing and
 updating in atusb
Message-ID: <20150611081745.GB972@omega>
References: <55782D54.2030508@osg.samsung.com>
 <00F27E6C-BEA0-42C5-8AF4-06A3CCEE320F@holtmann.org>
 <20150610152925.GD6647@omega>
 <20150610212351.GS5054@ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150610212351.GS5054@ws>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Werner Almesberger <werner@almesberger.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, Stefan Schmidt <stefan@osg.samsung.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>

On Wed, Jun 10, 2015 at 06:23:51PM -0300, Werner Almesberger wrote:
> Alexander Aring wrote:
> > I think the endpoint 0 is different between bootloader (dfu) and the
> > application (atusb). Maybe then add this functionality for the
> > bootloader only.
> 
> If you add it to the boot loader, then you need to flash your
> enhanced boot loader via in-circuit programming (or find a way
> to bypass the write protection. NB: no such way should exist.)
> Not everyone may find that convenient ;)
> 
> I'd leave the boot loader as it is and just add a new operation
> to the application part of the firmware.
> 

yea, this was just an idea because Marcel said:

"... you might want to push that device into a special mode to allow
programming of these settings"

and that's for me the dfu mode. My idea was just make the "new
operation" accessable in dfu endpoint only.

Nevertheless I am also fine with normal application operation, or making
some special bus access cycles to get into "privileged mode" or
something else, everything is possible.

- Alex

Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:59830 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbbE0OAG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 10:00:06 -0400
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: atusb availability
In-Reply-To: <C73127FC-6B86-48A0-820F-410AEFA7319D@cisco.com>
References: <CAHwW560VTApCL2a4c8uOMC2u-bWzenTf0vwH0pbeLZ3xNLuCOA@mail.gmail.com> <20150423083052.GA1077@omega> <CAHwW563+_YBjKLU7Pm8igBeOmWfUg_VEMhQ9Y-GosTdCPLBGUw@mail.gmail.com> <555F29B1.4010503@osg.samsung.com> <CAHwW5636ELxe1FU+pf5GjnvsgV3hAWqiYgSLmf4OSgi4SMW+CA@mail.gmail.com> <11929.1432731633@sandelman.ca>  <C73127FC-6B86-48A0-820F-410AEFA7319D@cisco.com>
Date: Wed, 27 May 2015 10:00:04 -0400
Message-ID: <27986.1432735204@sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Ralph Droms (rdroms)" <rdroms@cisco.com>
Cc: Geoff Chapman <geoff.chapman@mmbresearch.com>, Stefan Schmidt <stefan@osg.samsung.com>, Alexander Aring <alex.aring@gmail.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>


Ralph Droms (rdroms) <rdroms@cisco.com> wrote:
    > Is there an atusb-compatible version of Contiki for the AVR USBstick?

Maybe, but I think that the point here is to run the minimal firmware
required to talk to the radio and the USB, and nothing more.

If you run all of Contiki, then you might as well do all the 6lowpan
work there too.




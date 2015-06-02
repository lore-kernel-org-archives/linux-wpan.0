Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33876 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759470AbbFBQDa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Jun 2015 12:03:30 -0400
Received: by wgv5 with SMTP id 5so144161229wgv.1
        for <linux-wpan@vger.kernel.org>; Tue, 02 Jun 2015 09:03:28 -0700 (PDT)
Date: Tue, 2 Jun 2015 18:03:25 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: atusb availability
Message-ID: <20150602160322.GG1977@omega>
References: <CAHwW560VTApCL2a4c8uOMC2u-bWzenTf0vwH0pbeLZ3xNLuCOA@mail.gmail.com>
 <20150423083052.GA1077@omega>
 <CAHwW563+_YBjKLU7Pm8igBeOmWfUg_VEMhQ9Y-GosTdCPLBGUw@mail.gmail.com>
 <555F29B1.4010503@osg.samsung.com>
 <CAHwW5636ELxe1FU+pf5GjnvsgV3hAWqiYgSLmf4OSgi4SMW+CA@mail.gmail.com>
 <11929.1432731633@sandelman.ca>
 <C73127FC-6B86-48A0-820F-410AEFA7319D@cisco.com>
 <5565C759.4030000@osg.samsung.com>
 <20150527134748.GG712@omega>
 <0E9A4A46-ECE7-4F1B-B262-103AAAB5A424@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0E9A4A46-ECE7-4F1B-B262-103AAAB5A424@cisco.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Ralph Droms (rdroms)" <rdroms@cisco.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, Geoff Chapman <geoff.chapman@mmbresearch.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi Ralph,

On Wed, May 27, 2015 at 04:04:16PM +0000, Ralph Droms (rdroms) wrote:
> 
> > On May 27, 2015, at 9:47 AM 5/27/15, Alexander Aring <alex.aring@gmail.com> wrote:
> > 
> > On Wed, May 27, 2015 at 03:32:09PM +0200, Stefan Schmidt wrote:
> >> Hello.
> >> 
> >> On 27/05/15 15:29, Ralph Droms (rdroms) wrote:
> >>> Is there an atusb-compatible version of Contiki for the AVR USBstick?
> >>> 
> >> Hmm, not sure I got you correctly here. You mean contiki running on the AVR
> >> USBStick compatible with the atusb driver?
> >> If that was you question than the answer is no.
> >> 
> >> What Alex is working on is the atusb frimware (not contiki based) to work on
> >> the avr stick as well and thus being atusb driver compatible.
> >> 
> > 
> > If somebody want a firmware blob, I can upload the bin somewhere. Maybe
> > somebody has already a rzusb transceiver?
> 
> I have one ... At one point, I knew how to program it, so I can probably find the programmer and load your firmware blob.  So, please do upload the binary and let us know where it is...
> 

big sorry! I see your mail right now.

To all:
If I doesn't reponse to something, then please response with some "ping" mail.


I upload the firmware, you can download it at [0].

md5sum: a405f23abea9bbf34794f748138931a5  rzusb.bin

Remember this is a very experimental version of the firmware.

- Alex

[0] http://wpan.cakelab.org/firmwares/rzusb.bin

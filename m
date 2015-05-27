Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:44574 "EHLO
	rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbbE0QHb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 12:07:31 -0400
From: "Ralph Droms (rdroms)" <rdroms@cisco.com>
Subject: Re: atusb availability
Date: Wed, 27 May 2015 16:07:29 +0000
Message-ID: <AFBD4670-8E95-4DD9-951E-7ABAC8A39EAF@cisco.com>
References: <CAHwW560VTApCL2a4c8uOMC2u-bWzenTf0vwH0pbeLZ3xNLuCOA@mail.gmail.com>
 <20150423083052.GA1077@omega>
 <CAHwW563+_YBjKLU7Pm8igBeOmWfUg_VEMhQ9Y-GosTdCPLBGUw@mail.gmail.com>
 <555F29B1.4010503@osg.samsung.com>
 <CAHwW5636ELxe1FU+pf5GjnvsgV3hAWqiYgSLmf4OSgi4SMW+CA@mail.gmail.com>
 <11929.1432731633@sandelman.ca>
 <C73127FC-6B86-48A0-820F-410AEFA7319D@cisco.com>
 <27986.1432735204@sandelman.ca>
In-Reply-To: <27986.1432735204@sandelman.ca>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <85672CCA93268F46869372DA45B86FF5@emea.cisco.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Geoff Chapman <geoff.chapman@mmbresearch.com>, Stefan Schmidt <stefan@osg.samsung.com>, Alexander Aring <alex.aring@gmail.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>


> On May 27, 2015, at 10:00 AM 5/27/15, Michael Richardson <mcr@sandelman.ca> wrote:
> 
> 
> Ralph Droms (rdroms) <rdroms@cisco.com> wrote:
>> Is there an atusb-compatible version of Contiki for the AVR USBstick?
> 
> Maybe, but I think that the point here is to run the minimal firmware
> required to talk to the radio and the USB, and nothing more.
> 
> If you run all of Contiki, then you might as well do all the 6lowpan
> work there too.

I don't particularly want Contiki ... I'd like a raw interface through which I can hand more-or-less raw IEEE802.15.4 frames up to an application.

- Ralph

> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


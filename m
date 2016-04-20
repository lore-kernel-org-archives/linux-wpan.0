Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:33763 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbcDTUp6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Apr 2016 16:45:58 -0400
Subject: Re: drop all fragments inside tx queue if one gets dropped
References: <57175156.3050501@pengutronix.de>
 <11312.1461183334@obiwan.sandelman.ca>
From: Rick Jones <rick.jones2@hpe.com>
Message-ID: <5717EA7E.1020606@hpe.com>
Date: Wed, 20 Apr 2016 13:45:50 -0700
MIME-Version: 1.0
In-Reply-To: <11312.1461183334@obiwan.sandelman.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>, netdev@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>

For the "everything old is new again" files, back in the 1990s, it was 
noticed that on the likes of a netperf UDP_STREAM test on HP-UX, with 
fragmentation taking place, it was possible to consume 100% of the link 
bandwidth and have 0% effective throughput because the transmit queue 
was kept full with IP datagram fragments which could not possibly be 
reassembled (*) because one or more of the fragments of a datagram were 
dropped because the transmit queue was full.

HP-UX implemented "packet trains" where all the fragments of a 
fragmented datagram were presented to the driver, which then either 
queued them all, or none of them.

I don't recall seeing similar poor behaviour in Linux; I would have 
assumed that the intra-stack flow-control "took care" of it.  Perhaps 
there is something specific to wpan which precludes that?

happy benchmarking,

rick jones


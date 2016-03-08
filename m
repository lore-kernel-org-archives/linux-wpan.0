Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from tuna.sandelman.ca ([209.87.249.19]:42225 "EHLO
	tuna.sandelman.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbcCHONt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 8 Mar 2016 09:13:49 -0500
From: Michael Richardson <mcr@sandelman.ca>
Subject: Re: [6lo] big frame support in 802.15.4G
In-Reply-To: <CADrU+dKHiNd2xW0Nd=ZWJCAZQ_PbWXwNFo_V2u4nd7A_ccfwCw@mail.gmail.com>
References: <20160228140659.GA17980@omega> <28981.1457015214@obiwan.sandelman.ca> <20160304083528.GA1525@omega> <24416.1457106776@obiwan.sandelman.ca> <20160304163749.GA21798@omega> <18168.1457123400@obiwan.sandelman.ca> <56DC2A0A.6070906@htt-consult.com> <4538.1457367913@obiwan.sandelman.ca> <D302EF45.3625F%d.sturek@att.net> <56DDED58.5060500@htt-consult.com> <20160308082207.GA790@omega> <CADrU+dKHiNd2xW0Nd=ZWJCAZQ_PbWXwNFo_V2u4nd7A_ccfwCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24171.1457446427.1@obiwan.sandelman.ca>
Date: Tue, 08 Mar 2016 09:13:47 -0500
Message-ID: <24172.1457446427@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: robert.cragie@gridmerge.com
Cc: Alexander Aring <alex.aring@gmail.com>, Robert Moskowitz <rgm-ietf@htt-consult.com>, linux-wpan@vger.kernel.org, Don Sturek <d.sturek@att.net>, "6lo@ietf.org" <6lo@ietf.org>

Robert Cragie <robert.cragie@gridmerge.com> wrote:
    > I don't know the word "fraglettation"; I assume this is the same as
    > "fragmentation"? The device would need to invoke 6LoWPAN fragmentation
    > if the target device is a legacy device and the IPv6 frame is too large
    > to fit into the MSDU.

I thought that 6lowpan adopted the term "fraglet" to mean fragmentation below
IPv6, such that the term "fragment" could continue to refer to what happens
above IPv6 using the Fragmentation Header.

I see that I've mis-reremembered, and the term became "link fragment".

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [


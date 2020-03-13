Return-Path: <SRS0=xUNG=46=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B78BC10DCE
	for <linux-wpan@archiver.kernel.org>; Fri, 13 Mar 2020 22:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8842074B
	for <linux-wpan@archiver.kernel.org>; Fri, 13 Mar 2020 22:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ufpe.br header.i=@ufpe.br header.b="I2M7dV8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgCMWVe (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 13 Mar 2020 18:21:34 -0400
Received: from titan.ufpe.br ([150.161.6.80]:57743 "EHLO canit.ufpe.br"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgCMWVe (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 13 Mar 2020 18:21:34 -0400
Received: from zimbraufpe.ufpe.br (zimbraufpe.ufpe.br [150.161.6.73])
        by canit.ufpe.br (8.14.4/8.14.4/Debian-4) with ESMTP id 02DMLU7p073521
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wpan@vger.kernel.org>; Fri, 13 Mar 2020 19:21:30 -0300
Received: from localhost (localhost [127.0.0.1])
        by zimbraufpe.ufpe.br (Postfix) with ESMTP id BCCEA1634CE3A
        for <linux-wpan@vger.kernel.org>; Fri, 13 Mar 2020 19:21:34 -0300 (-03)
X-Virus-Scanned: amavisd-new at ufpe.br
Received: from zimbraufpe.ufpe.br ([127.0.0.1])
        by localhost (zimbraufpe.ufpe.br [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iQbTSBnFaahN for <linux-wpan@vger.kernel.org>;
        Fri, 13 Mar 2020 19:21:34 -0300 (-03)
Received: from zimbraufpe.ufpe.br (zimbraufpe.ufpe.br [150.161.6.73])
        by zimbraufpe.ufpe.br (Postfix) with ESMTP id 86DEE1634CE1D
        for <linux-wpan@vger.kernel.org>; Fri, 13 Mar 2020 19:21:34 -0300 (-03)
Date:   Fri, 13 Mar 2020 19:21:33 -0300 (BRT)
From:   Victhor Foster <victhor.foster@ufpe.br>
To:     linux-wpan <linux-wpan@vger.kernel.org>
Message-ID: <1193614528.1907358.1584138093678.JavaMail.zimbra@ufpe.br>
In-Reply-To: <20200313135423.zwimsw5u2o7dnanc@ryzen>
References: <547191739.3620092.1572042009933.JavaMail.zimbra@ufpe.br> <CAB_54W5B+bjAHQU-JYbg34=F5c0HMV9q30uPPtopHqNhNChO8A@mail.gmail.com> <2006988758.2143768.1573549407203.JavaMail.zimbra@ufpe.br> <763926392.1016039.1583799908366.JavaMail.zimbra@ufpe.br> <20200313135423.zwimsw5u2o7dnanc@ryzen>
Subject: Re: Interfacing mac802154 stack with userspace applications
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [179.54.215.254]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - GC80 (Linux)/8.8.7_GA_1964)
Thread-Topic: Interfacing mac802154 stack with userspace applications
Thread-Index: OD2++01la4IDMvor1/XRb8ravKsLzw==
X-Bayes-Prob: 0.5 (Score 0: No Bayes scoring rules defined, tokens from: SAIDA)
X-CanIt-Incident-Id: 012dWluA9
X-CanIt-Geo: ip=150.161.6.73; country=BR; region=Pernambuco; city=Recife; latitude=-8.05; longitude=-34.9000; http://maps.google.com/maps?q=-8.05,-34.9000&z=6
X-CanItPRO-Stream: SAIDA
X-Canit-Stats-ID: 012dWluA9 - 7ab956987d85 - 20200313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=ufpe.br; h=date:from:to
        :message-id:in-reply-to:references:subject:mime-version
        :content-type:content-transfer-encoding; s=ufpe201801; bh=miXrOt
        PkUl0dRhSXgD0r2Biyk+QquX8NzrMrYy5KufA=; b=I2M7dV8+qjYr3yJaDavXKA
        V8s98vtv1SZl8ycgHbT/8tCZBhW59fiW9qUcLX9+eltstHh+YiK0XjsD9DRvA0eh
        TBf2Opull/eYvVimt9DXOWSe4quDXvWEw9UMD5Haaqi86kGnYC0Davkf+TIzWzXI
        LAAZtYhUfKEbHXYJ5Il6N0eAlsrAuAUVn4sJvYqus+BMEdmD0OM0keTb+aFTbkRQ
        UXhMHnNNOp4OeSTHvwp+a9UkfK0ptOXeKFHlKLABJPz39EoEAObGQHKI17D/dcKS
        q7f+y/dyMiuuMFbJoaL3BscM86ak9zYI2Rk9knZpyuhPZq8qMK1uSOTKZkyHh9Bw
        ==
X-Scanned-By: CanIt (www . roaringpenguin . com) on 150.161.6.80
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

> Hi,
> 
> On Mon, Mar 09, 2020 at 09:25:08PM -0300, Victhor Foster wrote:
>> I have resumed work on this project, and I decided to implement a few
>> changes. I abandoned the socat approach and came up with a different
>> implementation, modifying the linux-wpan example programs.
>> 
> 
> aha, which one?
> 
I based my programs off the af_packet_rx and af_packet_tx examples.

>> I made two programs, one that receives packets from a wpan interface
>> and outputs them to a UDP port, while the other program receives
>> packets from a UDP port and sends them to a wpan interface. It seems
>> to work well enough, but there's a problem with my approach.
>> 
> 
> You telling me something about UDP to a wpan interface. This makes no
> sense except you also building some IP layer in user space.
> 

Sorry for the misunderstanding, I'll try to explain it better.
This is the data flow currently:

[GNU Radio]--UDP socket-->[program 1]--raw wpan socket-->[wpan0]
[GNU Radio]<--UDP socket--[program 2]<--raw wpan socket--[wpan0]
(wpan0 is a hwsim interface)

So the UDP socket is used only to transfer L2 packets to and from
GNU Radio, which is where the PHY is implemented.
This is like a SoftMAC-type radio, except the PHY is a userspace
application, and not a piece of hardware.
I'm trying to move L2 packets between my application and the wpan
interface.

>> I need to get outgoing packets from the wpan interface. Is there a way
>> to filter packets coming through a raw socket, such that only outgoing
>> packets come out of the socket?
>> 
> 
> Now you saying something about RAW sockets, what kind of raw sockets?
> 
Raw wpan sockets. Although I'm using ETH_P_ALL as the protocol, as the
ETH_P_IEEE802154 protocol type does not output outgoing packets.

>> Right now, I'm not filtering for outgoing packets, so when packets are
>> received through my program and sent to the wpan interface, the same
>> packets come out of the interface, as there's no filtering being done,
>> causing a loop.
>> 
>> I tried using the sll_pkttype field in the raw socket structure, but
>> all packets received by the socket have the same value, so it's not
>> useful, unfortunately.
>> 
> 
> No, it smells for me you want to do something with traffic control and
> egress path.

True. In the meantime, I have been working on a possible solution for my
problem, having the program that sends packets from the wpan interface
to my GNU Radio application do the following checks:

- Source MAC or short address is equal to the wpan interface's
- Destination MAC or short address is not equal to that of the wpan
interface
- Destination MAC or short address is equal to the broadcast address

I think this should avoid causing a loop. I haven't finished
implementing these features yet, so I don't know if they will be
effective.
It's not the same as having proper flow control, though. I would need
to implement a flow control mechanism to avoid this problem, I think.
> - Alex

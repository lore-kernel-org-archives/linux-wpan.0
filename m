Return-Path: <SRS0=8kPP=43=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEB2C10F25
	for <linux-wpan@archiver.kernel.org>; Tue, 10 Mar 2020 00:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612DF2465A
	for <linux-wpan@archiver.kernel.org>; Tue, 10 Mar 2020 00:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ufpe.br header.i=@ufpe.br header.b="BNlLXW/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgCJAiY (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:38:24 -0400
Received: from canit.ufpe.br ([150.161.6.80]:36675 "EHLO canit.ufpe.br"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbgCJAiX (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 9 Mar 2020 20:38:23 -0400
X-Greylist: delayed 790 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 20:38:21 EDT
Received: from zimbraufpe.ufpe.br (zimbraufpe.ufpe.br [150.161.6.73])
        by canit.ufpe.br (8.14.4/8.14.4/Debian-4) with ESMTP id 02A0P8TD108047
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wpan@vger.kernel.org>; Mon, 9 Mar 2020 21:25:08 -0300
Received: from localhost (localhost [127.0.0.1])
        by zimbraufpe.ufpe.br (Postfix) with ESMTP id 61D3B4906502
        for <linux-wpan@vger.kernel.org>; Mon,  9 Mar 2020 21:25:11 -0300 (-03)
X-Virus-Scanned: amavisd-new at ufpe.br
Received: from zimbraufpe.ufpe.br ([127.0.0.1])
        by localhost (zimbraufpe.ufpe.br [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AXqyWDriYnGC for <linux-wpan@vger.kernel.org>;
        Mon,  9 Mar 2020 21:25:11 -0300 (-03)
Received: from zimbraufpe.ufpe.br (zimbraufpe.ufpe.br [150.161.6.73])
        by zimbraufpe.ufpe.br (Postfix) with ESMTP id 3EE921631D946
        for <linux-wpan@vger.kernel.org>; Mon,  9 Mar 2020 21:25:11 -0300 (-03)
Date:   Mon, 9 Mar 2020 21:25:08 -0300 (BRT)
From:   Victhor Foster <victhor.foster@ufpe.br>
To:     linux-wpan <linux-wpan@vger.kernel.org>
Message-ID: <763926392.1016039.1583799908366.JavaMail.zimbra@ufpe.br>
In-Reply-To: <2006988758.2143768.1573549407203.JavaMail.zimbra@ufpe.br>
References: <547191739.3620092.1572042009933.JavaMail.zimbra@ufpe.br> <CAB_54W5B+bjAHQU-JYbg34=F5c0HMV9q30uPPtopHqNhNChO8A@mail.gmail.com> <2006988758.2143768.1573549407203.JavaMail.zimbra@ufpe.br>
Subject: Re: Interfacing mac802154 stack with userspace applications
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [179.54.215.254]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - GC80 (Linux)/8.8.7_GA_1964)
Thread-Topic: Interfacing mac802154 stack with userspace applications
Thread-Index: oOXlLZmZz5ktW44CUGICFR1dOSz5B7D/62iq
X-Bayes-Prob: 0.5 (Score 0: No Bayes scoring rules defined, tokens from: SAIDA)
X-CanIt-Incident-Id: 012cop8hz
X-CanIt-Geo: ip=150.161.6.73; country=BR; region=Pernambuco; city=Recife; latitude=-8.05; longitude=-34.9000; http://maps.google.com/maps?q=-8.05,-34.9000&z=6
X-CanItPRO-Stream: SAIDA
X-Canit-Stats-ID: 012cop8hz - 24bcb5e91368 - 20200309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=ufpe.br; h=date:from:to
        :message-id:in-reply-to:references:subject:mime-version
        :content-type:content-transfer-encoding; s=ufpe201801; bh=LcgZEg
        BpaU3leMsJyygLukQO3y4fvQeZrBs9cqikTL0=; b=BNlLXW/cF4b2LszMgoRdNM
        RHjczJYM0AJVgsQASF0YQ2Y1PDplIFYvX8Rp4SQWwVVM5h4dIW21eb4nwEMQCbyb
        ChCPMRz39r2Sj+7rbR2IO9Anq64YdoFlEcfYvQ8bFU44yqhrhdPmXf6fvKfF9TdG
        b0mmK3WepgoLoa4hBtBrrtYGSihwur9mO9ddgCaWkMrhtTz8eRQ3sAMGbitv9ZOw
        B/37Vo6R3RnrW9we1gfTWDKcm6v3Cni938XgEUoTZaFjSv+edsnklwqhkJE7HHBv
        z5XyBHVKft+LBkEWRhFQLGT+qTkZHxd3+/9e16QLmBH6QWcrJoKu9gnwsY0RiH0Q
        ==
X-Scanned-By: CanIt (www . roaringpenguin . com) on 150.161.6.80
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

I have resumed work on this project, and I decided to implement a few
changes. I abandoned the socat approach and came up with a different
implementation, modifying the linux-wpan example programs.

I made two programs, one that receives packets from a wpan interface
and outputs them to a UDP port, while the other program receives
packets from a UDP port and sends them to a wpan interface. It seems
to work well enough, but there's a problem with my approach.

I need to get outgoing packets from the wpan interface. Is there a way
to filter packets coming through a raw socket, such that only outgoing
packets come out of the socket?

Right now, I'm not filtering for outgoing packets, so when packets are
received through my program and sent to the wpan interface, the same
packets come out of the interface, as there's no filtering being done,
causing a loop.

I tried using the sll_pkttype field in the raw socket structure, but
all packets received by the socket have the same value, so it's not
useful, unfortunately.


> Hi Alexander,
> 
>> Hi Victhor,
>>
>> On Fri, Oct 25, 2019 at 6:39 PM Victhor Foster <victhor.foster@ufpe.br> wrote:
>>>
>>> Hello,
>>>
>>> I'm working on a project to implement a 6LoWPAN network using software defined
>>> radios. I'm trying to interface the kernel's 802.15.4/6LoWPAN stacks to my
>>> physical layer implemented in GNU Radio, instead of using a userspace stack,
>>> but this isn't working very well.
>>>
>>> The reason why I'm doing this is, while the GNU Radio plugin I'm using
>>> (gr-ieee802-15-4 from Bastian Bloessl) implements its own 802.15.4 MAC layer,
>>> I'd like to get around its limitations (such as not being able to change
>>> destination addresses at runtime) using the Linux kernel stack.
>>>
>>
>> It's possible to change the destination address. Do you use af802154?
>>
> I was referring to the MAC built into the GNU Radio plug-in. It doesn't use
> af802154, and there seems to be no way to change addresses at runtime on this
> plugin, from what I can tell.
> 
>>> The way this is being done is I have socat piping between a mac802154_hwsim
>>> interface and GNU Radio, using the following arguments: INTERFACE:wpan0
>>> UDP4-DATAGRAM:127.0.0.1:<port>
>>> GNU Radio is running a UDP server at <port> that transmits and receives PDUs
>>> to/from the software defined PHY, which then goes out to a software defined
>>> radio device (a USRP N210, in this case). So the PDUs are sent via the socat
>>> pipe to the hwsim network interface and vice-versa. The 802.15.4 MAC block is
>>> removed.
>>>
>>> While 802.15.4 packets are sent and received by both hosts, it seems these
>>> packets aren't getting through to the 6LoWPAN stack.
>>>
>> Mhh, do you can provide more information about the setup so I can test
>> it on my own? Do you took care about channel/page and panid settings?
>>
> I have a GNU Radio flowgraph that is based on one of the gr-ieee802-15-4
> examples. The PHY block's data input/output are connected to a "socket PDU"
> block that listens on a UDP port, and is able to send and receive data on this
> UDP port. The PHY block has signal input/output that is connected to the
> transmitter and receiver blocks for the SDR.
> To set up the hwsim interfaces, I made a script that runs the following commands
> on the host:
> 
> wpan-hwsim del 1
> ip link set down dev wpan0
> ip link set mtu 127 dev wpan0
> ip link add link wpan0 name lowpan0 type lowpan
> iwpan dev wpan0 set pan_id 0xabcd
> ip link set up dev wpan0
> ip link set up dev lowpan0
> 
> (ieee802154_socket and mac802154_hwsim modules are already loaded)
> 
> Then I launch GNU Radio and connect that to the hwsim interface using: socat
> UDP:127.0.0.1:<port on "socket PDU" block> INTERFACE:wpan0
> I have 2 hosts for testing, and these procedures are repeated on the other host
> (so they both have the same pan_id).
> lowpan* interfaces on both hosts are assigned a link-local address by the OS,
> which I don't change.
> Both hosts are running Ubuntu 18.04 with kernel package 5.0.0-29-generic from
> the repository.
> I have them set to the same channel/page and pan_id, but the channel/page
> doesn't matter as GNU Radio doesn't use these settings, it has its own
> frequency selection and both devices are operating on the same channel.
> 
> Hopefully this is a clear explanation of my setup.
> 
>>> During testing, I had packet capture set up on both the 802.15.4 ("wpan0") and
>>> the 6LoWPAN ("lowpan0") interfaces. The wpan0 interface was receiving packets
>>> from the other host (and also from itself, as the radio is full duplex), as
>>> expected. However, I could not get wpan-ping to work (timeout) and ping6,
>>> netcat, etc. wouldn't get a response from the other host.
>>> On the lowpan0 interface, I could see the packets originating from applications
>>> would appear on the packet capture log, but those that should be coming from
>>> the wpan0 interface wouldn't, even those originating from the host itself (due
>>> to the full duplex nature of the radio).
>>>
>>
>> No idea, this is now your gnuradio device?
> 
> Yes. GNU Radio is connected to the wpan0 device via the socat bridge.
> 
>>> I also noticed the following message on the kernel log: ieee802154 phy0 wpan0:
>>> encryption failed: -22
>>> I haven't touched the link encryption settings, so the traffic is unencrypted.
>>
>> This looks that you receive encrypted frames, it might be only the
>> frame control field is misleading and security is enabled, can you
>> check?
>>
> CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not enabled on this kernel, so link
> layer security is not available, I presume?
>>>
>>> What could be done to get the 6LoWPAN stack to accept packets injected into the
>>> 802.15.4 interface by socat? I realize this is a very unusual situation, but
>>> I'm not familiar with the Linux 802.15.4 stack.
>>
>> No idea, sorry for my late reply. Can you provide more information?
>>
> Sorry about my late reply as well, I needed access to the lab machine I was
> working on and I could only get it last Thursday, I tried to send this email
> with the GNU Radio file I used attached, and that got rejected, so I'm sending
> it again with this attachment removed.
> What I meant to say is, I want the stack to accept the packets from GNU Radio,
> so layer 3 and above will work i.e. the packets that are correctly decoded by
> the PHY are sent to the MAC, where they can be processed and sent to the layers
> above, so I can run applications over this link, thus allowing this system to
> be used to link multiple nodes together.
> 
> I had done another test a few days ago, but this time I eliminated the radios,
> instead I configured a loopback between the PHY input and output. I also set up
> another hwsim interface and had the edges set up so they could both communicate
> with each other.
> When I pinged one interface from the other, I could see a duplicated response,
> which came about a second or so later. This means GNU Radio adds significant
> latency, which was already known, but I wasn't accounting for this when I
> tested originally, I left the timeouts as default. I didn't expect the latency
> to be so significant. I might have to test this later using higher timeout
> settings.
> This setup was used to communicate with a Contiki node running their old Rime
> stack, as this is one of the examples included in the gr-ieee802-15-4 project,
> which is why I didn't expect latency to be such a problem.
> 
> 
> Victhor

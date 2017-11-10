Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw01.it.ntnu.no ([129.241.56.174]:57418 "EHLO
        mailgw01.it.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdKJX1k (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 10 Nov 2017 18:27:40 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Bridging a lowpan interface
From: David Palma <david.palma@ntnu.no>
In-Reply-To: <730.1510335972@obiwan.sandelman.ca>
Date: Sat, 11 Nov 2017 00:32:33 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <D59C859A-19A4-4898-A7E1-19C09BEBEA4E@ntnu.no>
References: <1BB434E6-8E27-4282-84FE-4CC88C48ED68@ntnu.no>
 <730.1510335972@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr+ietf@sandelman.ca>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi Michael,

Thanks for sharing your knowledge and views.

I'm all for routing and starting with RPL is fine. However, the idea was also to enable traffic differentiation based on flows (the SDN part), without breaking them, and not only based on IP addresses. That's why I mentioned that I used routing and ip6tables.

I was just wondering if there was a way of integrating lowpan interfaces with the other typical solutions.

Cheers,
--
David

> On 10 Nov 2017, at 18:46, Michael Richardson <mcr+ietf@sandelman.ca> wrote:
> 
> 
> David Palma <david.palma@ntnu.no> wrote:
>> After shamefully trying it, I suppose it's not possible to add a lowpan
>> interface to a bridge because it's not an ethernet segment.
> 
>> However, I was wondering if this could/will be a possibility in the
>> future?
> 
> No, because 802.15.4 uses 8-byte EUI64 addresses, or 2-byte short addresses.
> 
>> If I understood correctly there was a discussion about the tun/tap
>> driver that touched upon similar aspects, but I didn't get the
>> conclusion.
> 
>> The motivation for this question is to enable offloading/traffic
>> redirection between 15.4 and .11 depending on certain conditions
>> (e.g. energy and distance). I have accomplished this with changing
>> routes and iptables but I was looking for an "SDN/OpenFlow-like"
>> approach.
> 
> Stupid Layer-2 tricks are a bad idea here.
> Use smart layer-3 techniques instead: routing.
> 
> Assuming that both of your devices have 15.4 and .11 interfaces, then put
> them into seperate subnets, and then distribute /128 addresses to your end
> systems, and use a dynamic routing protocol to announce things.
> 
> Choices would include: RPL (see my unstrung.sandelman.ca, and others),
> BABEL, OSPFv3.
> 
> Before you complain about overhead of that, you need to go read the source
> code for the bridging code that includes {R,M,}STP.
> 
> --
> Michael Richardson <mcr+IETF@sandelman.ca>, Sandelman Software Works
> -= IPv6 IoT consulting =-
> 
> 
> 


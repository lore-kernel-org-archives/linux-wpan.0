Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:54582 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbaIBOvP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Sep 2014 10:51:15 -0400
Message-ID: <5405D961.4060006@xsilon.com>
Date: Tue, 02 Sep 2014 15:51:13 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: 6lowpan raw socket problems
References: <1409567774.3120.57.camel@jrissane-mobl.ger.corp.intel.com> <20140901113835.GA21564@omega> <1409638090.3120.71.camel@jrissane-mobl.ger.corp.intel.com> <20140902071214.GA25800@omega> <20140902072627.GB25800@omega> <5405D284.7020606@xsilon.com> <20140902144327.GA15189@omega>
In-Reply-To: <20140902144327.GA15189@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

The program can be found at this github. branch all_fixes.
https://github.com/smee204/unstrung/tree/all_fixes

The socket is created in iface.cpp network_interface::setup()
The receive problem is in iface.cpp network_interface::receive(const 
time_t now)

Thanks

Simon

On 02/09/14 15:43, Alexander Aring wrote:
> Hi Simon,
>
> On Tue, Sep 02, 2014 at 03:21:56PM +0100, Simon Vincent wrote:
>> I am having problems with raw sockets on a 6lowpan 802.15.4 interface. The
>> code works correctly on an ethernet ipv6 interface but not on a 6lowpan
>> interface. In the 6lowpan interface I receive packets but I find the src and
>> dest addresses are incorrect.
>>
>> I open the socket like this:
>> socket(AF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
>>
>> Add options for IPV6_RECVPKTINFO, IPV6_CHECKSUM, IPV6_RECVHOPLIMIT.
>>
>> I then receive a packet using recvmsg and attempt to get the source address.
>> The source address is rubbish. Also trying to get the destination address
>> from IPV6_PKTINFO using CMSG_FIRSTHDR results in rubbish.
>>
>> Can anyone explain why? Is there something different I have to do when using
>> 802.15.4 and 6lowpan?
>>
> Can you please send a test programm for this as example? Then I/We will
> look at why this happen.
>
> I think this would be the best to find why you have this issue. Doesn't
> need to be the full program only a small example.
>
>
> What I can say actually is:
> To send ICMPv6 packets from userspace you need RAW-Sockets. This is how
> ping6 do it and ping6 works on my side. Maybe there is a issue because
> some of your sockopts.
>
> - Alex


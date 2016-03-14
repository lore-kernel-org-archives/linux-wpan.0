Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53740 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965378AbcCNPeU (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 14 Mar 2016 11:34:20 -0400
Subject: Re: 802.15.4G support?
References: <CAH+RWqF-3Q8P52PTM9ZqpybEWTCKiubQK0-Y7L=c-3vAMhJfrg@mail.gmail.com>
 <20160228140659.GA17980@omega> <28981.1457015214@obiwan.sandelman.ca>
 <20160304083528.GA1525@omega> <24416.1457106776@obiwan.sandelman.ca>
 <20160304163749.GA21798@omega> <15462.1457122604@obiwan.sandelman.ca>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56E6D9F6.70308@osg.samsung.com>
Date: Mon, 14 Mar 2016 16:34:14 +0100
MIME-Version: 1.0
In-Reply-To: <15462.1457122604@obiwan.sandelman.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>, Alexander Aring <alex.aring@gmail.com>
Cc: Remi Philippe <remi@linqio.com>, linux-wpan@vger.kernel.org

Hello.

Having read through the mail threads on linux-wpan and ietf 6lo now.

On 04/03/16 21:16, Michael Richardson wrote:
> Alexander Aring <alex.aring@gmail.com> wrote:
>      > Okay. I think at first normal 127-bytes frames need to be send. After
>      > if you are sure that your "neighbor" uses a "SUN Phy" then you need to
>      > change the MTU (during runtime) for this special neighbor so a
>      > different handling can be done.
>
> Exactly... ND messages fit nicely in 127 bytes, and so the reply could
> say something.
>

That would be a way to tackle this mid term, agreed.

 From my sidem and with my linux hat on, this loks like the following.

1) 802.15.4 nodes can talk to 802.15.4g nodes on a physical level (it 
needs selection of the right modulation, frequency range, overlapping 
channels, etc) but it can happen and thus we need to be prepared for it.

2) If the 802.15.4g node uses a SUN PHY with a 2047 byte MTU we can run 
into trouble with normal nodes only able to handle 127. So far there is 
nothing specified to handle this case. Michael is proposing to use 6lo 
ND for this and record the MTU value for this neighbour in the l2 nd 
cache. Something that would certainly work but would need specing and 
implementing. I see this as a mid term goal we want to have. Anyone 
going to work on this?

3) Until 2) is done I would suggest we add a config option "802.15.4g 
with SUN PHY" which will change the hardcoded MTU from 127 to 2047 and 
will thus only work for a 15.g with SUN PHY only network. No interop as 
we have no way of knowing. The option would be disabled by default and 
the help text needs to mention the drawbacks. Once we have 2) in place 
we can remove this.

Remis, Alex, Michael how does this sound. It would allow Remi to go 
ahead and do the work needed to get his driver and things for 15.4g 
mainline while the interop problem can get further discussed, speced and 
implemented. Whats your folks opinion on this?

regards
Stefan Schmidt

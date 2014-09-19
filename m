Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:54023 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbaISJ5e (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 05:57:34 -0400
Message-ID: <541BFE0C.1050707@xsilon.com>
Date: Fri, 19 Sep 2014 10:57:32 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: 6lowpan raw socket problems
References: <541A9FD3.2030104@xsilon.com> <20140918094401.GB4350@omega> <20140918094501.GC4350@omega> <541AE5E9.3000407@xsilon.com> <20140918141911.GA9262@omega> <541B004D.1020609@xsilon.com> <20140918163008.GC9262@omega> <541B1068.4060707@xsilon.com> <20140918170938.GB11661@omega> <541BE8D9.2000700@xsilon.com> <20140919093335.GB17051@omega>
In-Reply-To: <20140919093335.GB17051@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net, mkl@pengutronix.de


On 19/09/14 10:33, Alexander Aring wrote:
> On Fri, Sep 19, 2014 at 09:27:05AM +0100, Simon Vincent wrote:
> ...
>>> Yep, then you could try to test what I did there. Simple save the
>>> address information in reserved skb data and then replacing data in
>>> lowpan_xmit callback. This also solves the capture on lowpan interfaces.
>>>
>>> lowpan_xmit should be save to replacing the header.
>> I am not 100% sure it is safe to replace the header at any point. How can
> me, too. We need to check that.
>
>> you guarantee that the skb has been read by the user application RAW socket
>> by this point? The user might not read the socket for seconds/minutes/hours.
>>
> no this can't happen. I need to dig into the code and running some
> ftrace to check if this can work. The RAW socket should not involved here.
>
> My theory is:
>
> The current behaviour is maybe (Maybe, because it's an assumption).
>
>   - IPv6 neighbor discovery magic
>     - calling create callback of header ops
>       This callback is only there to add data there not replacing data.
>       We do REPLACING the data so we can't parse the skb IPv6 header
>       anymore.
>     - After calling create callback of header ops IPv6 stack parse the
>       IPv6 header data which is inside of skb. We already replaced the
>       IPv6 header with 6LoWPAN header, so we can't parse it anymore but
>       IPv6 does it. -> WEIRD things happen.
>     - Finally lowpan interface calling xmit callback, this is at the end
>       of doing Layer 3 things, so we should sure that nobody parse it there.
>       What we do there is to queue the skb in the lower wpan interface.
>
>
> The solution would be (maybe):
>   - IPv6 neighbor discovery magic
>     - calling create callback of header ops
>       Putting necessary address information in skb reserved data. What
>       this means, see below. We don't replace the IPv6 header.
>     - After calling create callback of header ops IPv6 stack parse the
>       IPv6 header data which is inside of skb. We don't replace the
>       IPv6 header with 6LoWPAN header. -> all things are fine.
>     - Finally lowpan interface calling xmit callback, this is at the end
>       of doing Layer 3 things. Here we start to replacing IPv6 header
>       with 6LoWPAN header. The thing is, we need the address information
>       from create callback, that's why we saved it in skb reserved data.
>
>    

It does not look like it is safe to do it at xmit callback either. I 
have added debug printing out skb_shinfo(skb)->dataref in the compress 
function as well as the lowpan_xmit function and there are 3 refs to the 
data at both points. This makes sense as the packet would be sent to the 
802.15.4/ethernet/rawsocket as it is a multicast packet.
I think the only solution is to do a full copy of the packet in the 
6lowpan layer. Then we can modify the headers as much as we like. I know 
there is an overhead doing this but I can't see another way of avoiding 
this issue.

Simon
>
> What is the skb reserved data?
>
> We have a headroom and tailroom and then 4 pointers in the skb.
> _________________________________________________________________
> |  headroom     |       used skb data....      |     tailroom   |
> ^---------------^------------------------------^----------------^
>
> The '^' chars are pointers (don't know the real name in sk_buff struct,
> but data should be pointed at begin of "used skb data".
>
> What I did in the rework is:
>    - check if headroom is big enough to save "struct lowpan_addr"
>    - place lowpan_addr information in pointer:
>      (skb->data - (sizeof(struct lowpan_addr))).
>
> So this will crash when somebody make a skb_pull and skb_push in the
> middle of callback "create" of header_ops and lowpan_xmit callback.
> And manipulate data in there, or he do that like above without calling
> skb_foo functions.
> I don't know if there exist a state that this could happen.
> But I think in create callback of header_ops we have already the full
> IPv6 header, so I don't see why some IPv6 stack implementation should
> replacing it afterwards.
>
> Do you follow this here?
>
>> Also who should free the skb?
>>
>> Is is worth clarifying this with the netdev mailing list?
> To make a real solution for this issue, of course. I have only this one
> idea. To save address information into skb reserved data. We can't use
> skb->cb here, I already want to tried that. David Miller said to me that
> skb->cb could be overwritten by traffic control framework.
>
> I would first give a try if the above one fix your issue with RAW
> sockets.
>
> I cc Marc here, a co-worker of mine. Maybe he has also some other
> solution for this.
>
> - Alex


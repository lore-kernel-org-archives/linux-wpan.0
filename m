Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:56351 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731057AbfBRQDr (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 18 Feb 2019 11:03:47 -0500
Subject: Re: [PATCH RFC net-next] 6lowpan: use rbtree for IP frag queue
References: <20190215022953.128092-1-posk@google.com>
 <20190217230840.finshiu6s54cer4f@x220t>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <ba6e4a68-70ec-0661-d3dc-0d57e114bcb8@datenfreihafen.org>
Date: Mon, 18 Feb 2019 17:03:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190217230840.finshiu6s54cer4f@x220t>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>, Peter Oskolkov <posk@google.com>
Cc: David Miller <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, Peter Oskolkov <posk@posk.io>

Hello Peter.

On 18.02.19 00:08, Alexander Aring wrote:
> Hi,
> 
> On Thu, Feb 14, 2019 at 06:29:53PM -0800, Peter Oskolkov wrote:
>> This patch aligns IP defragmenation logic in 6lowpan with that
>> of IPv4 and IPv6: see
>> commit d4289fcc9b16 ("net: IP6 defrag: use rbtrees for IPv6 defrag")
>>
>> Modifying ip_defrag selftest seemed like an overkill, as I suspect
>> most kernel test setups do not have 6lowpan hwsim enabled. So I ran
>> the following code/script manually:
>>
>> 	insmod ./mac802154_hwsim.ko
>>
>> 	iwpan dev wpan0 set pan_id 0xbeef
>> 	ip link add link wpan0 name lowpan0 type lowpan
>> 	ip link set wpan0 up
>> 	ip link set lowpan0 up
>>
>> 	iwpan dev wpan1 set pan_id 0xbeef
>> 	ip netns add foo
>> 	iwpan phy1 set netns name foo
>> 	ip netns exec foo ip link add link wpan1 name lowpan1 type lowpan
>> 	ip netns exec foo ip link set wpan1 up
>> 	ip netns exec foo ip link set lowpan1 up
>>
>> 	ip -6 addr add "fb01::1/128" nodad dev lowpan0
>> 	ip -netns foo -6 addr add "fb02::1/128" nodad dev lowpan1
>>
>> 	ip -6 route add "fb02::1/128" dev lowpan0
>> 	ip -netns foo -6 route add "fb01::1/128" dev lowpan1
>>
>> 	# then in term1:
>> 	   ip netns exec foo bash
>> 	   ./udp_stream -6
>>
>> 	# in term2:
>> 	    ./udp_stream -c -6 -H fb02::1
>>
>> 	# pr_warn_once showed that the code changed by this patch
>> 	# was invoked.
>>
>> Signed-off-by: Peter Oskolkov <posk@google.com>
> 
> Acked-by: Alexander Aring <aring@mojatatu.com>
> 
> I tested this series and the code looks a lot simpler. Thanks.
> 
> Stefan do you see any issues?

 From my side it looks good as well. Thanks for the effort Peter to move
this one over as well!

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt

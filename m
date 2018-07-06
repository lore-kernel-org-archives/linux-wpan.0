Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:50519 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753421AbeGFIHM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jul 2018 04:07:12 -0400
Subject: Re: [PATCH wpan 1/2] net: 6lowpan: fix reserved space for single
 frames
References: <20180702203203.21316-1-aring@mojatatu.com>
 <a2cb217f-7e22-e603-bd46-13d8764fee64@datenfreihafen.org>
 <781a24ed-3783-abbf-7726-f377fd5eabca@ntnu.no>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <5e52e138-dd3c-de39-2bf7-09abd1314f3c@datenfreihafen.org>
Date: Fri, 6 Jul 2018 10:07:09 +0200
MIME-Version: 1.0
In-Reply-To: <781a24ed-3783-abbf-7726-f377fd5eabca@ntnu.no>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Palma <david.palma@ntnu.no>, Alexander Aring <aring@mojatatu.com>, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel@mojatatu.com, Rabi Narayan Sahoo <rabinarayans0828@gmail.com>

Hello David.

On 06.07.2018 09:54, David Palma wrote:
> Hi Stefan,
> 
> On 05/07/18 13:16, Stefan Schmidt wrote:
>> Hello.
>>
>> [CC David Palma and Rabi Narayan Sahoo]
>>
>> On 02.07.2018 22:32, Alexander Aring wrote:
>>> This patch fixes patch add handling to take care tail and headroom for
>>> single 6lowpan frames. We need to be sure we have a skb with the right
>>> head and tailroom for single frames. This patch do it by using
>>> skb_copy_expand() if head and tailroom is not enough allocated by upper
>>> layer.
>>>
>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195059
>>> Reported-by: David Palma <david.palma@ntnu.no>
>>> Reported-by: Rabi Narayan Sahoo <rabinarayans0828@gmail.com>
>>> Signed-off-by: Alexander Aring <aring@mojatatu.com>
>>
>> David, Rabi and you please test these two patches and verify that it
>> fixes the problems you have?
>>
>> regards
>> Stefan Schmidt
>>
> 
> The patches fix the problems!
> 
> I've tested them against different packet sizes and no kernel panic.

Thanks for confirming.

> The patches were applied in Debian's 4.9.88-1+deb9u1 x86_64 kernel,
> which before the patches showed the reported issue.

I will see that I get them into the stable kernel as well. For LTS or
Debian kernels you might want to poke the maintainers of them directly
once this patch had hit Linux mainline.

regards
Stefan Schmidt

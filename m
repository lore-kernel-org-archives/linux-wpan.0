Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:38475 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfCMJIt (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Mar 2019 05:08:49 -0400
Subject: Re: [PATCH] net: ieee802154: fix a potential NULL pointer dereference
References: <20190311072517.29740-1-kjlu@umn.edu>
 <BN3PR0301MB0897817BBE72CE6A33A1DE728E480@BN3PR0301MB0897.namprd03.prod.outlook.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <70435340-ecd3-2048-b1f2-b53e00a91d46@datenfreihafen.org>
Date: Wed, 13 Mar 2019 10:08:46 +0100
MIME-Version: 1.0
In-Reply-To: <BN3PR0301MB0897817BBE72CE6A33A1DE728E480@BN3PR0301MB0897.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>, Kangjie Lu <kjlu@umn.edu>
Cc: "pakki001@umn.edu" <pakki001@umn.edu>, Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello.

On 11.03.19 08:30, Hennerich, Michael wrote:
> 
> 
>> -----Original Message-----
>> From: Kangjie Lu [mailto:kjlu@umn.edu]
>> Sent: Montag, 11. März 2019 08:25
>> To: kjlu@umn.edu
>> Cc: pakki001@umn.edu; Hennerich, Michael <Michael.Hennerich@analog.com>; Alexander Aring <alex.aring@gmail.com>; Stefan
>> Schmidt <stefan@datenfreihafen.org>; David S. Miller <davem@davemloft.net>; linux-wpan@vger.kernel.org;
>> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: [PATCH] net: ieee802154: fix a potential NULL pointer dereference
>>
>> In case alloc_ordered_workqueue fails, the fix releases
>> sources and returns -ENOMEM to avoid NULL pointer dereference.
>>
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Strange enough patchwork did not pick up this acked by from you. I added
in manually to the patch. Just so you know.

regards
Stefan Schmidt

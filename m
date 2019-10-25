Return-Path: <SRS0=+EIT=YS=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2841CA9EA0
	for <linux-wpan@archiver.kernel.org>; Fri, 25 Oct 2019 04:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A6220867
	for <linux-wpan@archiver.kernel.org>; Fri, 25 Oct 2019 04:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbfJYEiq (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 25 Oct 2019 00:38:46 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:48264 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388090AbfJYEiq (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 25 Oct 2019 00:38:46 -0400
Received: from PC192.168.2.106 (p4FE7198A.dip0.t-ipconnect.de [79.231.25.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 1122AC1BBA;
        Fri, 25 Oct 2019 06:38:44 +0200 (CEST)
Subject: Re: [PATCH net-next] ieee802154: remove set but not used variable
 'status'
To:     David Miller <davem@davemloft.net>, yuehaibing@huawei.com
Cc:     varkabhadram@gmail.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191023070618.30044-1-yuehaibing@huawei.com>
 <20191024.151952.183800816459145037.davem@davemloft.net>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <e99fec11-9da5-318f-c617-157e041852a9@datenfreihafen.org>
Date:   Fri, 25 Oct 2019 06:38:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191024.151952.183800816459145037.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 25.10.19 00:19, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Wed, 23 Oct 2019 15:06:18 +0800
> 
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/net/ieee802154/cc2520.c:221:5: warning:
>>   variable status set but not used [-Wunused-but-set-variable]
>>
>> It is never used, so can be removed.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> I am assuming the WPAN folks will pick this up, thanks.

Correct. I was waiting for an ACK from the driver maintainer. Its simple 
enough to not need any further waiting though, applied now.

regards
Stefan Schmidt

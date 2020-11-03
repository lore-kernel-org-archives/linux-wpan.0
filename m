Return-Path: <SRS0=uuEQ=EJ=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2972FC2D0A3
	for <linux-wpan@archiver.kernel.org>; Tue,  3 Nov 2020 16:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B694520773
	for <linux-wpan@archiver.kernel.org>; Tue,  3 Nov 2020 16:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgKCQSq (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:18:46 -0500
Received: from proxima.lasnet.de ([78.47.171.185]:43632 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgKCQSq (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 3 Nov 2020 11:18:46 -0500
Received: from localhost.localdomain (p200300e9d729b09a69789643056dba7d.dip0.t-ipconnect.de [IPv6:2003:e9:d729:b09a:6978:9643:56d:ba7d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 44AE4C0B7B;
        Tue,  3 Nov 2020 17:18:44 +0100 (CET)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [PATCH 20/30] net: ieee802154: ca8210: Fix a bunch of kernel-doc
 issues
To:     Lee Jones <lee.jones@linaro.org>, davem@davemloft.net
Cc:     Harry Morris <h.morris@cascoda.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
References: <20201102114512.1062724-1-lee.jones@linaro.org>
 <20201102114512.1062724-21-lee.jones@linaro.org>
Message-ID: <bedd7739-5b10-89eb-52c9-31b2c3698b8d@datenfreihafen.org>
Date:   Tue, 3 Nov 2020 17:18:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201102114512.1062724-21-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 02.11.20 12:45, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/net/ieee802154/ca8210.c:326: warning: Function parameter or member 'readq' not described in 'ca8210_test'
>   drivers/net/ieee802154/ca8210.c:375: warning: Function parameter or member 'spi_transfer_complete' not described in 'ca8210_priv'
>   drivers/net/ieee802154/ca8210.c:375: warning: Function parameter or member 'sync_exchange_complete' not described in 'ca8210_priv'
>   drivers/net/ieee802154/ca8210.c:375: warning: Function parameter or member 'promiscuous' not described in 'ca8210_priv'
>   drivers/net/ieee802154/ca8210.c:430: warning: Function parameter or member 'short_address' not described in 'macaddr'
>   drivers/net/ieee802154/ca8210.c:723: warning: Function parameter or member 'cas_ctl' not described in 'ca8210_rx_done'
>   drivers/net/ieee802154/ca8210.c:723: warning: Excess function parameter 'arg' description in 'ca8210_rx_done'
>   drivers/net/ieee802154/ca8210.c:1289: warning: Excess function parameter 'device_ref' description in 'tdme_checkpibattribute'
>   drivers/net/ieee802154/ca8210.c:3054: warning: Function parameter or member 'spi_device' not described in 'ca8210_remove'
>   drivers/net/ieee802154/ca8210.c:3054: warning: Excess function parameter 'priv' description in 'ca8210_remove'
>   drivers/net/ieee802154/ca8210.c:3104: warning: Function parameter or member 'spi_device' not described in 'ca8210_probe'
>   drivers/net/ieee802154/ca8210.c:3104: warning: Excess function parameter 'priv' description in 'ca8210_probe'
> 
> Cc: Harry Morris <h.morris@cascoda.com>
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: linux-wpan@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I assume Dave or Jakub will apply the whole series directly. In that case:

Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt

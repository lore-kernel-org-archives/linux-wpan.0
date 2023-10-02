Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C698E7849A
	for <linux-wpan@archiver.kernel.org>; Mon,  2 Oct 2023 13:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbjJBNaB (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 2 Oct 2023 09:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbjJBNaA (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Oct 2023 09:30:00 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C85AD
        for <linux-wpan@vger.kernel.org>; Mon,  2 Oct 2023 06:29:57 -0700 (PDT)
Received: from [IPV6:2003:e9:d72e:6943:275b:1cf8:24c1:7dd3] (p200300e9d72e6943275b1cf824c17dd3.dip0.t-ipconnect.de [IPv6:2003:e9:d72e:6943:275b:1cf8:24c1:7dd3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id D827AC018F;
        Mon,  2 Oct 2023 15:29:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1696253396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQK5hP8LKyj4fRbbPFT09R5c9P73wdRtQNdBmFV2JcU=;
        b=LyHe0oWfUVqjxdgLPkoNCpbN1KnZ2DHL0HT3FDpv72H1YMMWYnFaCk3CfUzzcCPyEk9CnB
        FQM62EvuQAJ371I9jIJSqT9bHp+ZvweWpjGkE9tvt1wMJb4SQFPZ3yEvDLBBWplHX2fQ2B
        WS2Drmb98Tvhll2kTqzojitq41bKpLr+Q7d03CKQAfJ9ogE+EzEN7A/ponH1Gr11jTt84a
        dnDEDUE9JNJv8RLPMPPlR5T4tvt2VLd6NUDLhRBSXV7VWHjZn4jfK+IQtC5Oug9uoGMKzz
        OzWKvmX/LpDHFqsnomFipE4wE7GFbJ6I0fJDg99ufygnzqkjFJS3TWKU91WVPA==
Message-ID: <f06abe68-5347-5cde-8d9a-cfc3b3439269@datenfreihafen.org>
Date:   Mon, 2 Oct 2023 15:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/9] wpan-tools: switch to SPDX header for license and
 copyright
Content-Language: en-US
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        david.girault@qorvo.com
References: <20230924122231.716878-1-stefan@datenfreihafen.org>
 <20230925092202.0ab39c04@xps-13>
 <f390bb8d-c412-97c4-d574-4bde89bae5a2@datenfreihafen.org>
 <CAK-6q+gOK9EEM_uyARj7AipPhbPYu=00rsAYD3tz+qbHcAXEuQ@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <CAK-6q+gOK9EEM_uyARj7AipPhbPYu=00rsAYD3tz+qbHcAXEuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 02.10.23 01:37, Alexander Aring wrote:
> Hi,
> 
> On Tue, Sep 26, 2023 at 4:00 AM Stefan Schmidt
> <stefan@datenfreihafen.org> wrote:
>>
>> Hello Miquel, Alex.
>>
>> On 25.09.23 09:22, Miquel Raynal wrote:
>>> Hi Stefan,
>>>
>>> stefan@datenfreihafen.org wrote on Sun, 24 Sep 2023 14:22:22 +0200:
>>>
>>>> Hello.
>>>>
>>>> I took some time to convert wpan-tools over to using the SPDX header format to
>>>> express copyright and license information. In this process we make the actual
>>>> license (ISC) more clear and allow downstream users of wpan-tools to have a
>>>> machine readable format for license compliance.
>>>>
>>>> We are also using the reuse tool in our CI to check for this now and generate a
>>>> SBOM file as an example.
>>>
>>> Nice addition!
>>>
>>> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>
>> Thanks Miquel.
>>
>> Alex, any remarks from your side or are you happy for me to land this in
>> wpan-tools?
>>
> 
> looks okay to me.

Thanks you two. Pushed to master now.

regards
Stefan Schmidt

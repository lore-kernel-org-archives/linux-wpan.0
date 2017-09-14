Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:44767
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751133AbdINNgA (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Sep 2017 09:36:00 -0400
Subject: Re: [PATCH v1 1/2] mac802154: Fix MAC header and payload encrypted
References: <CAC9NHkkHZJLk7_shZ37jFqp06Gu9Qg1Eu=sGi_259GjhkpSftg@mail.gmail.com>
 <1504613884-20870-1-git-send-email-dvnp@cesar.org.br>
 <8310e188-12d4-245e-2c18-a3e7e765af80@osg.samsung.com>
 <CAC9NHknYZ7=FqwkXSHpXKQKBD74b7ddaDA=q=O5j-wkXhpMSJw@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <ac862186-29d0-07f3-4479-639ecea6cbf8@osg.samsung.com>
Date: Thu, 14 Sep 2017 15:35:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAC9NHknYZ7=FqwkXSHpXKQKBD74b7ddaDA=q=O5j-wkXhpMSJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?Q?Di=c3=b3genes_Vila_Nova_Pereira?= <dvnp@cesar.org.br>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Claudio Koiti Takahasi <ckt@cesar.org.br>

Hello.

On 09/13/2017 06:28 PM, Diógenes Vila Nova Pereira wrote:
> Hello,
> 
> LLC implementation that I checked some like Contiki, Zephyr and RIOT are 
> in specifications compliance.  All of them build the standard MHR and it 
> inserts the Auxiliary Security Header(ASH) with the Security Enabled bit 
> ON without encrypting them.

Thanks for taking the time to check the other implementations so we can 
feel safe to apply this change. Will ack the patch in a separate mail.

regards
Stefan Schmidt



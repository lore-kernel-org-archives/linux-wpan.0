Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36488 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdFZEI7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 26 Jun 2017 00:08:59 -0400
Subject: Re: [PATCH net-next v2 5/5] net: add netlink_ext_ack argument to
 rtnl_link_ops.slave_validate
References: <cover.1498425679.git.mschiffer@universe-factory.net>
 <ae78184571760c3430159ea5a654e3d08ba2479d.1498425679.git.mschiffer@universe-factory.net>
 <2a529345-ab92-aa14-7f1e-f8af3a9026eb@gmail.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <a10f5268-2e7d-58c9-5745-c9c67b698cdf@gmail.com>
Date: Sun, 25 Jun 2017 22:08:56 -0600
MIME-Version: 1.0
In-Reply-To: <2a529345-ab92-aa14-7f1e-f8af3a9026eb@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matthias Schiffer <mschiffer@universe-factory.net>, dledford@redhat.com, sean.hefty@intel.com, hal.rosenstock@gmail.com, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, wg@grandegger.com, mkl@pengutronix.de, pablo@netfilter.org, laforge@gnumonks.org, paulus@samba.org, jiri@resnulli.us, dsa@cumulusnetworks.com, shm@cumulusnetworks.com, davem@davemloft.net, stephen@networkplumber.org, arvid.brodin@alten.se, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@trash.net, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, johannes@sipsolutions.net
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-ppp@vger.kernel.org, linux-wpan@vger.kernel.org

On 6/25/17 10:05 PM, David Ahern wrote:
> On 6/25/17 3:56 PM, Matthias Schiffer wrote:
>> Add support for extended error reporting.
>>
>> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
>> ---
> 
> Acked-by: David Ahern <dsahern@gmail.com>
> 

And slave_validate is not used; it should be removed.

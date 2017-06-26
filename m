Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36208 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdFZNd7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 26 Jun 2017 09:33:59 -0400
Subject: Re: [PATCH net-next v2 4/5] net: add netlink_ext_ack argument to
 rtnl_link_ops.slave_changelink
References: <cover.1498425679.git.mschiffer@universe-factory.net>
 <498ff06f59d5ce13b2ad3e1c1902c3d348ca3c00.1498425679.git.mschiffer@universe-factory.net>
 <b097a69e-4449-b124-c39e-4dbdbae7c218@gmail.com>
 <dd3f596b-4519-398c-a2ec-afdaf5f2f058@gmail.com>
 <15d2138d-5026-a35b-8a3c-2a88d05df688@universe-factory.net>
From: David Ahern <dsahern@gmail.com>
Message-ID: <27b8d607-7442-0a42-1389-9548840445dc@gmail.com>
Date: Mon, 26 Jun 2017 07:33:50 -0600
MIME-Version: 1.0
In-Reply-To: <15d2138d-5026-a35b-8a3c-2a88d05df688@universe-factory.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matthias Schiffer <mschiffer@universe-factory.net>, dledford@redhat.com, sean.hefty@intel.com, hal.rosenstock@gmail.com, j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, wg@grandegger.com, mkl@pengutronix.de, pablo@netfilter.org, laforge@gnumonks.org, paulus@samba.org, jiri@resnulli.us, dsa@cumulusnetworks.com, shm@cumulusnetworks.com, davem@davemloft.net, stephen@networkplumber.org, arvid.brodin@alten.se, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@trash.net, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, johannes@sipsolutions.net
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-ppp@vger.kernel.org, linux-wpan@vger.kernel.org

On 6/26/17 2:43 AM, Matthias Schiffer wrote:
> On 06/26/2017 06:08 AM, David Ahern wrote:
>> On 6/25/17 10:04 PM, David Ahern wrote:
>>> On 6/25/17 3:56 PM, Matthias Schiffer wrote:
>>>> Add support for extended error reporting.
>>>>
>>>> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
>>>> ---
>>>
>>>
>>> Acked-by: David Ahern <dsahern@gmail.com>
>>>
>>
>> Actually, you are missing the chagne to br_port_slave_changelink.
>>
> 
> I'm confused. I am changing br_port_slave_changelink? All my patches are
> compile-tested.
> 

You are changing the signature of slave_changelink, no?

net/bridge/br_netlink.c:
        .slave_changelink       = br_port_slave_changelink,

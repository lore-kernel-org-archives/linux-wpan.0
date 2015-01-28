Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:55499 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933839AbbA2DjW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 28 Jan 2015 22:39:22 -0500
Received: by mail-wi0-f169.google.com with SMTP id h11so3671595wiw.0
        for <linux-wpan@vger.kernel.org>; Wed, 28 Jan 2015 19:39:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAkG1NNuLqYtcEoKYPAnviiaVD4TqdoEsRP-MWqpLokBZ6-tkg@mail.gmail.com>
References: <CAAkG1NMPUEg1jo=a84vndiScGQkox8SZHzRsVQ9EAP=-12sEag@mail.gmail.com>
	<CAAkG1NMx59Xma0pwUmEZkGaDVmw521xDzdKrHiVfx3Aw08M=4g@mail.gmail.com>
	<CAAkG1NNuLqYtcEoKYPAnviiaVD4TqdoEsRP-MWqpLokBZ6-tkg@mail.gmail.com>
Date: Wed, 28 Jan 2015 19:33:18 +0530
Message-ID: <CAAkG1NMn5KEGTU3e0rbn7tAnFbEVftkoq3Vj29La=myqjQ5V8w@mail.gmail.com>
Subject: Re: Sample code for 6Lo tx/rx
From: Rohit Kulkarni <rmkulkar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I had made some embarrasing blunders to get the "Protocol not
supported" error!! :-)

I finally got the at86rf212 module to tx data. Here's the code that
worked, in case someone else is also looking for an example. Also, can
any of you just glance through it and let me know if something's wrong
with it?

Thanks!
Rohit

#include <sys/types.h>
#include <sys/socket.h>
#include <ieee802154.h>

#include <strings.h>    /* bzero() */
#include <unistd.h>     /* sleep() */

int main()
{
        struct sockaddr_ieee802154 host_addr;
        struct sockaddr_ieee802154 dest_addr;

        /* Create a 802.15.4 socket */
        int sock = socket(AF_IEEE802154, SOCK_DGRAM, 0);
        if(sock < 0)
        {
                perror("socket");
                return -1;
        }

        /* Fill in the host_addr object */
        bzero(&host_addr, sizeof(host_addr));

        host_addr.family         = AF_IEEE802154;
        host_addr.addr.addr_type = IEEE802154_ADDR_SHORT;
        host_addr.addr.pan_id    = 0xdead;
        host_addr.addr.short_addr= 0xbeef;

        if(bind(sock, (struct sockaddr *)&host_addr, sizeof(host_addr)) < 0)
        {
                perror("bind");
                return -1;
        }

        /* Fill in the dest_addr object */
        bzero(&dest_addr, sizeof(dest_addr));

        dest_addr.family    = AF_IEEE802154;
        dest_addr.addr.addr_type = IEEE802154_ADDR_SHORT;
        dest_addr.addr.pan_id    = 0xdead;
        dest_addr.addr.short_addr= 0xbeee;

        while(1)
        {
                if(sendto(sock, "Hello World", 12, 0, (struct sockaddr
*)&dest_addr, sizeof(dest_addr)) < 0)
                {
                        perror("sendto");
                        close(sock);
                        return -1;
                }

                sleep(2);
        }

        close(sock);
        return 0;
}

On Wed, Jan 28, 2015 at 4:46 PM, Rohit Kulkarni <rmkulkar@gmail.com> wrote:
> Hi,
>
> I'm sorry for re-posting the same query. Gmail was acting up and said
> the earlier one could not be delivered!
>
> -Rohit
>
> On Wed, Jan 28, 2015 at 4:39 PM, Rohit Kulkarni <rmkulkar@gmail.com> wrote:
>> Hi,
>>
>> I was wondering if there is any example code that can tx/rx over a
>> 6LoWPAN "node" interface. I've looked through the Unstrung code for
>> some examples but it uses ICMP all over. I'd really appreciate if
>> someone had any code samples for sending udp data over wpan. I tried
>> creating a SOCK_DGRAM socket over AF_IEEE802154 and got the "Protocol
>> not supported" error. Creating a SOCK_RAW worked but my life would be
>> much easier if I could start using DGRAMs :-) (One of the earlier
>> emails on the list mentioned DGRAMs over 6LoWPAN!).
>>
>> Also, I've never used RAW sockets before, so any help with RAW sockets
>> over wpan (if DGRAM is not really an option) will also be a huge help!
>>
>> Thanks!
>> -Rohit

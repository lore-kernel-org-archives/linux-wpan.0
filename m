Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:61077 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbaIROg6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 10:36:58 -0400
Message-ID: <541AEE07.8030804@xsilon.com>
Date: Thu, 18 Sep 2014 15:36:55 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: Promiscuous patches
References: <541A9E65.3090300@xsilon.com> <20140918094123.GA4350@omega> <541AAE3A.80306@xsilon.com> <20140918104322.GA5217@omega> <541AC962.7090301@xsilon.com> <20140918122140.GA6777@omega> <20140918123024.GB6777@omega> <20140918124430.GA8268@omega> <541ADD3B.8090706@xsilon.com> <20140918133424.GA8458@omega> <20140918134210.GB8458@omega>
In-Reply-To: <20140918134210.GB8458@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org


On 18/09/14 14:42, Alexander Aring wrote:
> On Thu, Sep 18, 2014 at 03:34:24PM +0200, Alexander Aring wrote:
> ...
>>> I want to be able from COORD or NODE mode to put the device in promiscuous mode so packets can be received by wireshark.  For example if we are seeing a problem on a device, I want to be able to ssh into this node via Ethernet (or maybe connect via the serial console) and run tcpdump -U -i wpan0 to help debugging by seeing what packets are being sent/received.  As it's going to stdout it will be sent over ssh and I can then do some pipe redirection to pipe it into Wireshark running on a different machine.
>>>
>>> From my understanding this is not MONITOR mode and I don't won't to put the device into MONITOR mode as this could effect it's functionality.
>>> I'm currently looking at how tcpdump does this and it looks like it uses a raw socket using PF_PACKET.  I think it then sets the IFF_PROMISC flag on this socket to put the device into promiscuous mode.  As I'm in COORD or NODE mode this will arrive at the ndo_change_rx_flags for the net device ops defined in wpan.c not monitor.c in my linux tree.
> Has nothing to do with raw sockets, I think.
I'm just going on what I'm seeing in libpcap, I think tshark and tcpdump both use this library.  If you have a debug environment setup, set a breakpoint on activate_new or look through pcap-linux.c, one of the first things it does is:
    sock_fd = is_any_device ?
        socket(PF_PACKET, SOCK_DGRAM, htons(ETH_P_ALL)) :
        socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));

is_any_device should be set to false as we are capturing a specific device so we should be creating a raw socket.  Then later on
    if (!is_any_device && handle->opt.promisc) {
        memset(&mr, 0, sizeof(mr));
        mr.mr_ifindex = handlep->ifindex;
        mr.mr_type    = PACKET_MR_PROMISC;
        if (setsockopt(sock_fd, SOL_PACKET, PACKET_ADD_MEMBERSHIP,
            &mr, sizeof(mr)) == -1) {
            snprintf(handle->errbuf, PCAP_ERRBUF_SIZE,
                "setsockopt: %s", pcap_strerror(errno));
            close(sock_fd);
            return PCAP_ERROR;
        }
    }
Then I think this ends up in the kernel at packet_dev_mc
http://lxr.free-electrons.com/source/net/packet/af_packet.c#L3060
which calls dev_set_promiscuity.



>
>>> I notice in your linux-wpan-next alex/wip branch there is no wpan.c or monitor.c, and I can't see how I can be a COORD or NODE and capture packets.
>>>
> ahh these types are only for the rework. Mainline is NODE = WPAN and
> COORD doesn't exist.
>
> COORD is the new type for handling some pan coordinator functionality
> inside of kernelspace. Forget this.
>
>> Then you simple need to rum wireshark/tcpdump etc.
>>
>> I use:
>>
>> "ssh root@$IP 'tshark -i wpan0 -w -' | wireshark -k -i -"
>>
>> replace $IP with $IP of ethernet 802.15.4 node. Then you only see frames
>> with filtering and belongs to you and whatever any interface capture then.
>> Require ssh on both, tshark on target and wireshark on host.
>>
>>
>> What we talking about is promiscousmode setting according 802.15.4-2011.
>> With that you don't need to set any register setting, just start
> s/With/In this case/
>> capturing the interface. Also no special handling for IFF_PROMISC is
>> needed.
> I hope we comming near to any solution what we both want. :-/
I think I understand enough now to add what I need so I can keep this out of your linux-wpan mainline tree.  :)
> - Alex

- Martin.
